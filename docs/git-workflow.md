# Git Workflow

This document defines the recommended Git workflow for StartKit.

## Branch strategy

- `main`
  - stable branch
  - release source
- feature branches
  - create from `main`
  - open a pull request back into `main`

Example branch names:

- `feature/add-gh-module`
- `fix/windows-winget-detection`
- `docs/readme-quickstart-update`

---

## Pull request flow

1. Create a branch from `main`
2. Make your changes
3. Add or update documentation if needed
4. Add a `.changeset/*.md` file for user-facing changes
5. Open a pull request to `main`

---

## PR checks

The repository uses the following CI checks:

### `pr-check.yml`
Validates:

- shell syntax for `.sh` files
- basic CLI smoke test
  - `start-kit help`
  - `start-kit version`
  - `start-kit list modules`
  - `start-kit list profiles`

### `changeset-check.yml`
Validates:

- a `.changeset/*.md` file exists for non-doc changes

Docs-only changes are excluded from the changeset requirement.

---

## Changeset workflow

For any change that affects users, add a changeset file.

Typical examples:

- new module
- new profile
- CLI behavior change
- contract change
- README or docs change that changes usage expectations

Create a changeset locally with:

```bash
npx changeset
```

or create a markdown file manually under:

```text
.changeset/
```

Example:

```md
---
"start-kit": minor
---

Add dependency confirmation UX for module installs.
```

---

## Release flow

Releases are created from `main` using the release workflow.

Recommended sequence:

1. Merge pull requests into `main`
2. Ensure changesets are present
3. Trigger the release workflow
4. The workflow:
   - runs `changeset version`
   - updates release metadata
   - creates a Git tag
   - creates a GitHub Release

---

## Commit guidance

There is no strict commit format requirement in core, but clear commit messages are recommended.

Examples:

- `feat: add dependency confirmation UX`
- `fix: improve winget package mapping`
- `docs: update framework-not-distribution section`

---

## Philosophy

StartKit is a framework, not a distribution.

That means Git workflow should optimize for:

- clarity
- reviewability
- small isolated changes
- minimal side effects
- explicit release notes
