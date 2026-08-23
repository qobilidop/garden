import { defineConfig } from 'astro/config'
import { unified } from '@astrojs/markdown-remark'
import remarkMath from 'remark-math'
import rehypeKatex from 'rehype-katex'
import remarkWikilinks from './src/lib/wikilinks.mjs'
import { buildResolveMap, lintContent } from './src/lib/sitemap.mjs'

// Served at the domain root (custom domain on Pages); a '/sub' prefix
// here must match `base` below.
const BASE = ''
const resolve = buildResolveMap(BASE)
lintContent(resolve)

export default defineConfig({
  site: 'https://qobilidop.com',
  base: BASE || '/',
  // v7 defaults to 'jsx' whitespace stripping, which eats significant
  // spaces between text and inline elements; keep HTML semantics.
  compressHTML: true,
  markdown: {
    processor: unified({
      remarkPlugins: [
        remarkMath,
        [remarkWikilinks, { resolve }],
      ],
      rehypePlugins: [rehypeKatex],
    }),
    syntaxHighlight: {
      type: 'shiki',
      excludeLangs: ['mermaid', 'math'],
    },
  },
})
