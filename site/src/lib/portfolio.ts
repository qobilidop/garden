// The portfolio record: loads portfolio/portfolio.yaml and validates
// its shape at build time, so an invalid record fails the build. Each
// entry is a work with its own home: `url` is where to read or use it,
// `repository` where it is built, `started` its first commit date.
import { readFileSync } from 'node:fs'
import { resolve } from 'node:path'
import { parse } from 'yaml'
import { z } from 'astro/zod'

const url = z.string().url()
const entry = z
  .object({
    title: z.string(),
    started: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
    summary: z.string(),
    url,
    repository: url,
  })
  .strict()

const schema = z.array(entry)

export type PortfolioEntry = z.infer<typeof entry>

// cwd-anchored, like cv.ts: builds always run from site/.
const file = resolve(process.cwd(), '../portfolio/portfolio.yaml')
export const portfolio: PortfolioEntry[] = schema.parse(parse(readFileSync(file, 'utf8')))
