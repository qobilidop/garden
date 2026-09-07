# Capture edge cases

Open when `capture-post.mjs` cannot get the page as-is, the source is
git-backed, the work is paywalled, or a check flags the capture tool.

- **Fallbacks, in order**, when SingleFile cannot get the page (bot
  wall, login, paywall): the SingleFile extension in the user's own
  browser session, which yields the same artifact kind (run
  `capture-post.mjs` afterwards with a `file://` URL to annotate and
  extract; unverified — check the first time); then a verified existing
  Wayback original-content record (`web.archive.org/web/<ts>id_/<url>`)
  as the capture URL. A frontmatter comment records the fallback.
- **Author-versioned source** (a gist or other git-backed page): pin the
  revision — capture the raw file at its commit sha alongside the page
  capture and verify the two agree. When the work is the
  author's own canonicalization of an earlier post (tweet → gist),
  record the original appearance as a second identity — frontmatter
  comment plus first discussions entry, with a text capture to shadow.
- **Paywalled source**: the free preview is the record — capture it,
  state the paywall in a frontmatter comment, scope the notes to it, and
  name re-capture through the user's browser session as the upgrade
  path. Claims about the gated remainder from secondary sources are not
  asserted.
- **Tool maintenance**: `capture-post.mjs` changes only when a check
  flags a post — extraction ratio, never-loaded images, prose diff —
  and only by a generic fix, one commit per fix naming the flagging
  post, so git is the ledger. A need that would take a site-specific
  patch takes the browser-capture fallback or a transcript caveat
  instead. Fixes outpacing ingestions is the signal to swap the
  extractor; the checks make the swap cheap. (Nine generic fixes came
  out of the first migration of 32 posts, none from reading files.)
