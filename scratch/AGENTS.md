# scratch/ conventions

- Notes live at `scratch/YYYY/YYYY-MM-DD/slug.md`. The date directory
  is the capture date and the H1 is the title — no date or title
  frontmatter: the path and git history are their canonical homes.
  When intra-day order matters, state the dependency in prose
  ("written after X settled"), not clock words — dependencies verify,
  clock words drift.
- Every note carries `author:` frontmatter naming its prose author —
  `Bili Dong`, or the agent model matching the commit trailer:

  ```markdown
  ---
  author: Claude Fable 5
  ---
  ```

  Required for everyone including Bili: an optional field fails
  silently (a forgotten field misattributes), a required field fails
  loudly. Machine-checked by `hooks/lint.sh`.
- Scratch is outside the maintained link graph: durable layers never
  link into it — it expires at reseed, and the site does not render
  it. `[[…]]` inside scratch is informal notation, unresolved.
  Pointers out of scratch into durable layers are the distill
  direction.
