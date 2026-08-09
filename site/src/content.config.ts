// The allowlist: the site reads exactly these three collections and
// nothing else in the repo. Library IDs are citekeys (the parent
// directory name); survey IDs are the campaign slug — the collection
// entry is the survey's landing page (index.md); the manuscript
// renders (HTML/PDF) are compiled separately into site/public/ by
// scripts/build-manuscripts.py.
import { defineCollection } from 'astro:content'
import { glob } from 'astro/loaders'

const wiki = defineCollection({
  loader: glob({ base: '../wiki', pattern: '*.md' }),
})

const library = defineCollection({
  loader: glob({
    base: '../library',
    pattern: '**/notes.md',
    generateId: ({ entry }) => entry.split('/').at(-2)!,
  }),
})

const surveys = defineCollection({
  loader: glob({
    base: '../surveys',
    pattern: '*/index.md',
    generateId: ({ entry }) => entry.split('/').at(-2)!,
  }),
})

export const collections = { wiki, library, surveys }
