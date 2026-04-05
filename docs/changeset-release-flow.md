# Changeset Release Flow

## Goal

Use Changesets as the source of truth for release notes, and update `CHANGELOG.md` automatically during the release process.

---

## Flow

```text
Pull Request
  ↓
Add .changeset/*.md
  ↓
Merge into main
  ↓
Run release workflow
  ↓
npx changeset version
  ↓
CHANGELOG.md updated automatically
  ↓
VERSION updated
  ↓
Commit generated release changes
  ↓
Create git tag
  ↓
Create GitHub Release
```

---

## Required files

- `.changeset/config.json`
- `CHANGELOG.md`
- release workflow

---

## Release workflow behavior

Recommended sequence in CI:

1. checkout repository
2. setup Node.js
3. install Changesets
4. run `npx changeset version`
5. commit updated files
6. push changes
7. read version from `VERSION`
8. create tag
9. create GitHub Release

---

## Important note

`CHANGELOG.md` should **not** be edited manually for normal releases.

Normal release history should be generated from `.changeset/*.md`.

Manual edits are acceptable only for:
- initial bootstrap
- migration
- correcting obvious formatting issues
