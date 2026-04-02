# README Asset TODOs

Use this checklist when replacing placeholder assets with real files.

## Architecture diagram

Target file:
- `assets/readme/diagrams/architecture-overview.png`

TODO:
- [ ] Export a real architecture diagram image
- [ ] Keep width readable in GitHub README
- [ ] Ensure labels match current terminology:
  - module
  - profile
  - package manager abstraction
  - platform
- [ ] Update the diagram when core responsibilities change

Suggested source file to keep:
- `assets/source/architecture-overview.drawio`

---

## Quick start demo GIF

Target file:
- `assets/readme/demos/quickstart-demo.gif`

TODO:
- [ ] Record a short 5–10 second demo
- [ ] Show:
  - `start-kit install profile base`
  - `git --version`
  - `start-kit doctor`
- [ ] Keep the GIF size small enough for README loading
- [ ] Prefer terminal theme with readable contrast

Suggested source file to keep:
- `assets/source/quickstart-demo.mov`

---

## Hero image (optional)

Target directory:
- `assets/readme/hero/`

TODO:
- [ ] Decide whether a hero image is actually needed
- [ ] If added, keep it minimal and product-focused
- [ ] Avoid duplicating information already stated in the title/subtitle

---

## README maintenance

TODO:
- [ ] Replace placeholder references once final assets are committed
- [ ] Verify image paths in both `README.md` and `README.ja.md`
- [ ] Confirm GitHub renders the images correctly
