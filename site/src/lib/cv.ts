// The CV record: loads cv/cv.yaml and validates its shape at build
// time, so an invalid record fails the build. The schema is the
// canonical home of the file's shape conventions:
//   - dates: `year` = dated occurrence, `start`/`end` = tenure —
//     exactly one shape per entry;
//   - locus: `venue` = publication outlet, `event` = dated gathering,
//     `org` = organization — each section admits only its own.
import { readFileSync } from 'node:fs'
import { resolve } from 'node:path'
import { parse } from 'yaml'
import { z } from 'astro/zod'

const year = z.number().int()
const occurrence = { year }
const tenure = { start: year, end: z.union([year, z.literal('present')]) }

const entry = <T extends z.ZodRawShape>(shape: T) =>
  z.union([
    z.object({ ...shape, ...occurrence, note: z.string().optional() }).strict(),
    z.object({ ...shape, ...tenure, note: z.string().optional() }).strict(),
  ])

const url = z.string().url()
const employment = entry({ role: z.string(), org: z.string() })
const education = entry({ degree: z.string(), org: z.string() })
const publication = z
  .object({
    title: z.string(),
    authors: z.string(),
    venue: z.string(),
    year,
    url,
    note: z.string().optional(),
  })
  .strict()
const talk = entry({ title: z.string(), event: z.string(), url })
const service = entry({ role: z.string(), event: z.string(), url })
  .or(entry({ role: z.string(), org: z.string(), url }))

const schema = z
  .object({
    name: z.string(),
    as_of: z.coerce.date(),
    links: z.record(z.string(), url),
    employment: z.array(employment),
    education: z.array(education),
    publications: z.array(publication),
    talks: z.array(talk),
    service: z.array(service),
  })
  .strict()

export type CV = z.infer<typeof schema>
export type Dated = { year: number } | { start: number; end: number | 'present' }

// cwd-anchored: builds always run from site/ (npm sets cwd to the
// package dir; CI sets working-directory) — import.meta.url is not
// usable here because the prerender bundle relocates this module.
const file = resolve(process.cwd(), '../cv/cv.yaml')
export const cv: CV = schema.parse(parse(readFileSync(file, 'utf8')))

// One formatter for both date shapes, shared by every section.
export const dates = (d: Dated): string =>
  'year' in d ? String(d.year) : `${d.start} – ${d.end}`
