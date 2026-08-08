---
author: Claude Fable 5
---

# rclone Drive store: own OAuth client + drive.file scope

2026-08-07. Context: rclone's shared Google Drive client_id retires during
2026, and the `store:` remote had been riding it (empty `client_id` in
rclone.conf — the retirement NOTICE on every push was the tell). Migrated
to a personal OAuth client, then narrowed the grant so the token can only
touch files the client itself created.

## End state

- Dedicated GCP project; Google Drive API enabled.
- OAuth consent (Google Auth Platform): External audience, **published to
  Production** — an app left in "Testing" issues refresh tokens that
  expire every 7 days, which would break pushes weekly and silently.
- OAuth client type: Desktop app.
- `~/.config/rclone/rclone.conf` `[store]`: personal client_id/secret,
  `scope = drive.file`, `root_folder_id` = a folder the client created.
  drive.file means the token sees only files/folders this app created —
  the consent screen literally says "only the specific Google Drive files
  you use with this app," and `rclone lsjson store:` at root confirms it
  (nothing else in the Drive is listed, let alone editable).
- Store blobs re-uploaded under the new client identity. This is forced,
  not optional: drive.file visibility is per-app, so files uploaded by
  the old shared client are invisible to the new one. Manifest
  regenerated — all remote file IDs changed.
- rclone.conf is host-local by design and never mirrored into `config/`:
  it carries the client secret and a live refresh token. dev.sh mounts it
  into the container (writable, so refreshed tokens persist).

## Playbook

1. **Console** (browser): create project → enable Drive API → Auth
   Platform "Get started" (app name, support email, External, contact,
   agree to policy) → Audience → **Publish app** → Clients → Create
   client → Desktop app. Capture credentials with Download JSON — the
   secret is shown only in that dialog — and delete the file once step 2
   is done.
2. `rclone config update store client_id <id> client_secret <secret> scope drive.file`
3. **Token, headless-friendly**:
   `rclone authorize drive <id> <secret> --drive-scope drive.file --auth-no-open-browser`
   → open the printed `127.0.0.1:53682` URL in any logged-in browser →
   pick account → Continue → the command prints a token JSON →
   `rclone config update store token '<json>'`.
   Gotchas found the hard way: `--auth-no-open-browser` belongs to
   `authorize`, not `config reconnect`; the base64-blob argument form
   rejected both standard and url-safe encodings (byte-218 decode error)
   — the positional id/secret form plus `--drive-scope` is the reliable
   path. Full `drive` scope triggers the unverified-app interstitial
   (Advanced → continue); `drive.file` does not.
4. **New root folder** (must be app-created): `rclone mkdir store:<name>`
   → `rclone lsjson store: --dirs-only` for its ID →
   `rclone config update store root_folder_id <ID>`.
5. `tools/store.sh push` (re-uploads the local cache, regenerates the
   manifest), then `tools/store.sh check`.
6. The old folder is invisible to the new token — delete it manually in
   the Drive web UI.

## Maintenance triggers

- Auth broken (token revoked/expired/scope error): redo step 3 only.
- **Revoking any refresh token for the client revokes the client's whole
  grant for that user** — every token dies, including newer ones from
  separate consents (observed 2026-08-08: revoking a superseded
  full-scope token 401'd the active drive.file token). To retire a
  superseded token, revoke and immediately re-run step 3; there is no
  selective revocation. Also scrub any plaintext token JSON left in
  task-output/temp files once the config holds it.
- Client secret leaked: console → Clients → reset secret → steps 2–3.
- New machine: copy rclone.conf, or redo step 3 there.
- Any scope or folder change: steps 2–5, remembering drive.file cannot
  see other apps' files — re-upload rather than chase old IDs.
- `root_folder_id` is a convenience pointer, not a boundary; the
  boundary is the scope.
