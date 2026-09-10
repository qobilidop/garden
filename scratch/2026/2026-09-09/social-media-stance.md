---
author: Claude Fable 5.1
---

# Social media stance: minimal accounts, pull-shaped reading, POSSE only

Bili's decision, reached over one session that began as a design
discussion for a `stream/` micro-blog layer and ended by rejecting
it. The stance that survived: author only on qobilidop.com; keep the
few accounts that reading and syndication need; treat platforms as
distribution for finished work and as lookup, never as a routine.
The one repo change is the removal of the stream placeholder page
and nav entry (the "share" group lists blog only).

Method note: protocol facts come from two single-agent web passes
(ActivityPub and AT Protocol) plus direct fetches of the pages
cited; usage figures are Similarweb via TechCrunch; the follow-up
accounts are the authors' own posts. "Unverified" marks the gaps.
Not panel-verified.

## The question and what was rejected

**A `stream/` layer of short public posts.** Every job it would do
has another home: link reactions are library ingestions minus the
broadcast, and the broadcast is a platform post; short durable
thoughts are blog posts once the self-imposed "days of composition"
rule for blog is relaxed to "deliberate and durable, any length";
announcements are the blog's own syndication posts; presence and
encounters come from having an account, not from archiving what was
said. What remains for stream alone is ephemeral chatter, which is
exactly the content that needs no permalink on the domain. The
evidence agreed: the layer had been designed repeatedly since August
and held three posts, none of which reached this repository, while
the site page said "nothing has grown here yet" from the day it was
created — appetite for the system, not the writing.

**Speaking a social protocol from the static site.** Neither
protocol can be served by files alone. ActivityPub needs a live
server to accept signed Follow requests and to sign and POST every
post into follower inboxes ([W3C spec](https://www.w3.org/TR/activitypub/),
[Mastodon security](https://docs.joinmastodon.org/spec/security/));
AT Protocol needs a Personal Data Server holding a signed repository
([repository spec](https://atproto.com/specs/repository)). What a
static site *can* carry is identity at the domain: a Bluesky handle
resolves through `/.well-known/atproto-did`
([handle spec](https://atproto.com/specs/handle)), a Fediverse
handle through WebFinger, Nostr through `/.well-known/nostr.json`.
The domain is the switchboard; the backend behind each file is
replaceable. Cloudflare's own Workers ActivityPub server, Wildebeest,
is archived; Fedify runs on Workers but would make the Worker real
server code, which the site contract avoids.

**Bluesky-first with capture into git.** The best-fitting design
before the layer itself was rejected: a native account (handle at
the domain, a rotation key held by Bili so the account can move
hosts without Bluesky's cooperation), posts written in the phone
app, a daily job pulling the public repository export
(`com.atproto.sync.getRepo`, no auth) and committing each record
verbatim, the site minting a permalink per record key. Key facts
that make it clean: the export holds only the account's own records
(a repost or like is a URI plus content hash, never someone else's
text); client-chosen record keys make `putRecord`/`deleteRecord`
idempotent
([createRecord lexicon](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)),
so app-born (timestamp-keyed) and repo-born (permalink-keyed) posts
could coexist without a two-way sync. Deferred, not rejected: the
export is retroactive, so an account opened later loses nothing.
Triggers to open one: wanting a reply thread the site can render, or
wanting a portable identity.

**Fediverse bridging.** Bridgy Fed gives a domain-native handle by
polling or receiving webmentions from the site, cannot propagate
edits, and bridges only opted-in accounts in either direction
([docs](https://fed.brid.gy/docs)). Deprioritized once broadcast
stopped being the goal.

**A "multiverse" view of all activity across platforms.** Rendering
is a merge by timestamp; ingestion is where platforms diverge —
Bluesky's export is one public file, Mastodon needs a token, X's read
API is paid, LinkedIn has none. Dropped as over-engineering before
the platform question was even settled.

## The stance

- **Author only on the domain.** Blog for finished work; scratch for
  working material; anything not meant for anyone stays private.
  Concession: finished posts are syndicated, with the links recorded
  in the post.
- **Read by pull, not by feed.** Library ingestion is the intake;
  RSS, arXiv alerts, and a couple of topical fora are the sources.
  Concession: the accounts stay for the rare lookup and for fields
  whose conversation only exists there. Browsing is a lookup, not a
  routine.
- **React as a gift, never as a record.** A like does two jobs: the
  bookmark belongs in the library, the feedback belongs to the
  poster and is consumed on sight. Nothing is archived, so nothing
  needs purging. Privacy varies by platform (X likes private since
  2024; Bluesky likes are public records), which is a reason to
  choose where to react, not to delete history.
- **Be findable, not present.** Contact links on the site, email on
  papers, GitHub, Scholar, ORCID; collaboration starts from work
  someone found, then email. Concession: a few events a year and a
  presence in the fora where the projects live (the Lean Zulip, P4
  working groups, LLVM/MLIR Discourse).

Accounts kept: X (lookup, syndication), LinkedIn (professional,
syndication), GitHub. No new accounts.

## Blog syndication design (waits for the blog)

Each post's frontmatter carries a `syndication:` map keyed by
platform (`x`, `linkedin`, `bluesky`, … → URL). The key selects a
site adapter in `site/src/lib/`; the map is plain data. The page
renders a "discuss on …" line from the map and, for adapters whose
replies are fetchable, the reply thread fetched client-side at view
time — a conscious exception to the site loading nothing from third
parties, to be stated in the site contract when built. Bluesky and
Mastodon threads are fetchable without auth (the Bluesky-thread-as-
comment-section pattern:
[Zue](https://www.coryzue.com/writing/bluesky-comments/),
[Lowin](https://www.jlowin.dev/blog/bluesky-comments)); X cannot
feed replies back (Bridgy lost API access 2023-04-04,
[brid.gy/about](https://brid.gy/about)); LinkedIn has an "Embed this
post" iframe but no reply API. Publishing is two-step: deploy, share,
paste URLs, deploy. Sections stack; tabs only if two fetchable
platforms ever exist. GitHub Discussions is the comment channel that
needs no new account.

## Evidence that the price is visibility, nothing else

Follow-up accounts by people who left the feed: Lawson at five years
("My blog posts get less traffic than they used to, I don't get
invited to as many conferences anymore"; would not return —
[post](https://nolanlawson.com/2022/02/02/five-years-of-quitting-twitter/));
an NLP researcher at one year ("the natural diffusion process still
worked well enough"; returned mindfully —
[post](https://nightingal3.github.io/blog/2024/03/27/living-without-twitter/));
Scalzi at two years, who changed venue rather than quit
([post](https://whatever.scalzi.com/2025/11/18/two-years-post-twitter/));
Newport, who never joined. None settled on silent lurking; each
replaced the feed with pull-shaped sources.

Platform state at decision time (Similarweb via
[TechCrunch, 2026-08-11](https://techcrunch.com/2026/08/11/blueskys-active-user-base-is-shrinking-as-its-focus-expands-beyond-the-app/)):
Bluesky 10.4 M monthly active in June 2026, down 27 % year on year
and about half its Q4 2024 peak, 46 M registered; Mastodon under
1 M monthly active (secondary sources); Threads 147 M daily active.
Irrelevant to the stance, recorded so a future revisit knows what
was known.
