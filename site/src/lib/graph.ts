// Backlink graph over the wiki + library + surveys collections: scan every
// document's raw body for [[targets]], invert into an inbound map. Computed
// once per build and cached.
import { getCollection } from 'astro:content'
import { extractTitle } from './works'

const LINK_RE = /\[\[([^[\]]+)\]\]/g

export interface Ref {
  id: string
  kind: 'wiki' | 'library' | 'survey'
  href: string
  title: string
}

let cache: Promise<Map<string, Ref[]>> | null = null

export function getInbound(): Promise<Map<string, Ref[]>> {
  cache ??= build()
  return cache
}

function outboundTargets(body: string): Set<string> {
  const targets = new Set<string>()
  for (const m of body.matchAll(LINK_RE)) {
    const name = m[1].split('|', 1)[0].split('#', 1)[0].trim()
    if (name) targets.add(name)
  }
  return targets
}

async function build(): Promise<Map<string, Ref[]>> {
  const base = import.meta.env.BASE_URL.replace(/\/$/, '')
  const docs = [
    ...(await getCollection('wiki')).map((e) => ({
      id: e.id,
      kind: 'wiki' as const,
      href: `${base}/wiki/${e.id}/`,
      body: e.body ?? '',
    })),
    ...(await getCollection('library')).map((e) => ({
      id: e.id,
      kind: 'library' as const,
      href: `${base}/library/${e.id}/`,
      body: e.body ?? '',
    })),
    ...(await getCollection('surveys')).map((e) => ({
      id: e.id,
      kind: 'survey' as const,
      href: `${base}/surveys/${e.id}/`,
      body: e.body ?? '',
    })),
  ]
  const inbound = new Map<string, Ref[]>()
  for (const doc of docs) {
    const ref: Ref = {
      id: doc.id,
      kind: doc.kind,
      href: doc.href,
      title: extractTitle(doc.body) ?? doc.id,
    }
    for (const target of outboundTargets(doc.body)) {
      if (target === doc.id) continue
      if (!inbound.has(target)) inbound.set(target, [])
      inbound.get(target)!.push(ref)
    }
  }
  for (const refs of inbound.values()) {
    refs.sort((a, b) => a.title.localeCompare(b.title))
  }
  return inbound
}
