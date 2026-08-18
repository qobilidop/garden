---
citekey: willison2025-lethal-trifecta
work:
  title: "The lethal trifecta for AI agents: private data, untrusted content, and external communication"
  author: Simon Willison
  date: 2025-06-16
source: https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/  # snapshot + figure (1 JPEG) → shadow
discussions:
  - https://news.ycombinator.com/item?id=44289295  # 2025-06-16
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "Agent risk becomes structurally acute when one execution path combines private-data access, attacker-controlled input, and an exfiltration channel; the robust control is to break that capability triangle rather than trust probabilistic prompt defenses."
---

# The lethal trifecta for AI agents: private data, untrusted content, and external communication

Willison compresses indirect prompt injection into a capability-composition
test. An agent becomes an attractive data-exfiltration target when it can
simultaneously access private data, ingest content controlled by an attacker,
and communicate externally. Each capability is useful in isolation; their
composition lets instructions embedded in email, documents, web pages, images,
or tool results induce the model to retrieve and transmit data.

## The unit of risk is the whole path

The post's strength is architectural. Looking only at individual tools misses
the attack: one component may read a private store, another may fetch public
content, and a third may make an HTTP request. Once the model can connect those
edges, a malicious document can become control input and an innocuous image
load, link, API call, or pull request can become an output channel.

Prompt hierarchy is not a dependable security boundary because trusted and
untrusted natural-language instructions ultimately enter the same model
context. Additional prompting and classifiers may lower attack probability,
but Willison argues that a defense advertised as 95% effective is inadequate
for a repeatable exfiltration opportunity. The durable mitigation is to break
the triangle: after untrusted input enters a path, prevent it from authorizing
consequential data access or communication.

The article grounds the pattern in a sequence of then-recent production
incidents and highlights a GitHub MCP case in which public issues supplied
untrusted instructions, private repositories supplied sensitive data, and pull
request creation supplied an exfiltration path. Those incidents establish that
the capability pattern occurred in deployed systems; the post is not a
systematic incidence study and its linked vendor fixes may age.

## This is a gate-placement rule

The threat model extends [[self-evolving-agents]]'s consensus architecture.
That shelf already puts evaluation and persistence permissions outside the
component being modified. The trifecta adds information-flow authority: a
model influenced by untrusted content should not independently exercise the
capabilities needed to disclose protected state. Maker/checker separation is
insufficient if both roles share the same secrets and outbound channel.

Likewise, the file system and external tools celebrated by
[[weng2026-harness]] are not neutral affordances. Their usefulness depends on
read, write, network, provenance, and approval boundaries. The danger is not
"agents" as a label; it is a concrete path across those boundaries.

- **Durable:** reason about composed capabilities and end-to-end information
  paths; treat untrusted natural-language content as potentially executable;
  and prefer removing an edge over relying exclusively on probabilistic input
  detection.
- **Era-bound:** the named 2023–2025 incidents, MCP ecosystem maturity, vendor
  mitigations, and current guardrail claims.
- **Evidence boundary:** this is a practitioner threat-model essay backed by
  linked examples, not a measured attack-success distribution. The best exact
  Hacker News submission has one brief comment and adds no substantive
  adjudication.
- **Stake:** Willison coined and has extensively documented the term *prompt
  injection*. The framing is part of his public security advocacy, but the post
  is not selling a guardrail product and explicitly distrusts such claims.

The phrase is memorable because it turns a vague warning into a review
question: for every attacker-controlled input, can the influenced execution
reach both a sensitive source and an externally observable sink? If yes, the
system should be redesigned before model-level guardrails are credited.
