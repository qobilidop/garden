// The allowlist: the site reads exactly these three collections and
// nothing else in the repo (plus the CV and portfolio records loaded
// in src/lib/). Library IDs are citekeys (the parent directory name);
// notebook IDs are the note-XXXX file stems.
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

const notebook = defineCollection({
  loader: glob({ base: '../notebook', pattern: 'note-*.md' }),
})

export const collections = { wiki, library, notebook }
