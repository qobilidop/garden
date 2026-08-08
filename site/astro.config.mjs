import { defineConfig } from 'astro/config'
import { unified } from '@astrojs/markdown-remark'
import remarkMath from 'remark-math'
import rehypeKatex from 'rehype-katex'
import remarkWikilinks from './src/lib/wikilinks.mjs'
import { buildResolveMap } from './src/lib/sitemap.mjs'

const BASE = '/sys0'

export default defineConfig({
  site: 'https://qobilidop.github.io',
  base: BASE,
  // v7 defaults to 'jsx' whitespace stripping, which eats significant
  // spaces between text and inline elements; keep HTML semantics.
  compressHTML: true,
  markdown: {
    processor: unified({
      remarkPlugins: [
        remarkMath,
        [remarkWikilinks, { resolve: buildResolveMap(BASE) }],
      ],
      rehypePlugins: [rehypeKatex],
    }),
    syntaxHighlight: {
      type: 'shiki',
      excludeLangs: ['mermaid', 'math'],
    },
  },
})
