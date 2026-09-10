# notebook/ conventions

- Notes live at `notebook/note-XXXX.md`: four lowercase base-36
  characters (`0-9a-z`), minted sequentially — the next ID is the
  largest existing one plus one, counted in base 36. IDs are never
  reused; a gap is history. Filenames are machine-checked by
  `hooks/lint.sh`.
- The H1 is the title. Each note has one clear goal or boundary;
  what falls outside it is another note. No frontmatter: the
  layer has one author, and the title, ID, and git history are
  the canonical homes of everything a header would restate. Epistemic status ("conjecture", "settled", "abandoned")
  is a line on the page, never a directory.
- A note is undated and revised in place; git is its history.
- Voice rule: agents never author prose here. Mechanical link
  retargeting is the one exception. Claim inventories drawn from a
  session go to `scratch/`, and the note is written by hand from
  them.
- `[[note-XXXX]]` names a note. Wiki slugs and library citekeys link
  as they do everywhere else. Scratch is outside the link graph
  (`scratch/AGENTS.md`): notes may cite a scratch record by plain
  path, never link to it.
