// The allowlist: the site reads exactly these two collections and nothing
// else in the repo. Library IDs are citekeys (the parent directory name).
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

export const collections = { wiki, library }
