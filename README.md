![StartKit Header](./assets/readme/header/header.png)

# StartKit

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)]()
[![Shell](https://img.shields.io/badge/Shell-Bash-green)]()
[![Status](https://img.shields.io/badge/status-active-success)]()
[![English](https://img.shields.io/badge/lang-English-blue)](./README.md)
[![日本語](https://img.shields.io/badge/lang-日本語-green)](./README.ja.md)

> 🇯🇵 Japanese: [README.ja.md](./README.ja.md)

**Composable environment setup for developers across macOS and Windows.**

StartKit is a modular CLI framework for building development environments with:

- **modules**: one tool = one module
- **profiles**: use-case-based groups of modules
- **custom**: local overrides without polluting OSS core

<details>
<summary>Table of Contents</summary>

- [⚙️ Initial Setup](#-initial-setup)
- [🚀 1-minute quick start](#-1-minute-quick-start)
- [✨ Why StartKit?](#-why-startkit)
- [🧩 Features](#-features)
- [🏗 Architecture](#-architecture)
- [🧠 Core concepts](#-core-concepts)
- [📕 Framework, not Distribution](#-framework-not-distribution)
- [🖥 Platform support](#-platform-support)
- [📦 Custom](#-custom)
- [📖 CLI](#-cli)
- [📄 Contracts](#-contracts)
- [⚠️ Uninstall policy](#-uninstall-policy)
- [🤝 Contributing](#-contributing)
- [📜 License](#-license)

</details>

## ⚙️ Initial Setup

Follow these steps to set up StartKit:

```bash
git clone <repo>
cd start-kit

export PATH="$PWD/bin:$PATH"
start-kit init
```

This will:
- Add the start-kit CLI to your PATH
- Initialize the StartKit environment

Depending on your operating system, follow one of the setups below:
- [macOS Setup](#macos-setup)
- [Windows Setup](#windows-setup)

### macOS Setup

```bash
start-kit install profile macos-bootstrap
```

This will:
- Ensure Homebrew is available

### Windows Setup

```bash
start-kit install profile windows-bootstrap
```

This will:
- Ensure winget (and optionally scoop) is available

## 🚀 1-minute quick start

Try StartKit in under a minute.

```bash
start-kit install profile base
```

Verify:

```bash
git --version
start-kit doctor
```

> **Note on `git`**
>
> StartKit is often obtained via `git clone`, but this is just one of several distribution methods.
> You can also use a zip archive or any other way to get the repository.
>
> The `git` module is included in the core not as a requirement for StartKit itself,
> but as:
>
> - a practical base tool used in most environments
> - a reference implementation of cross-platform package manager abstraction
>
> In other words, how you obtain StartKit and what StartKit manages are intentionally separate concerns.

## ✨ Why StartKit?

Most setup repositories are hard-coded for one machine, one person, or one team.

StartKit takes a different approach:

- keep the **core small**
- define tools as **independent modules**
- group them with **profiles**
- allow **local overrides**
- avoid dangerous abstractions like unified uninstall

This makes StartKit useful as:
- a personal setup framework
- a team bootstrap foundation
- an OSS base that others can extend

## 🧩 Features

- Modular architecture
- Profile-based composition
- Idempotent execution
- Local customization via `custom/`
- Doctor command for validation
- Scaffold commands for modules and profiles
- Cross-platform structure for macOS and Windows
- Dependency resolution with confirmation UX
- `--yes` and `--dry-run` support
- Minimal core by design

## 🏗 Architecture

![Architecture overview](./assets/readme/diagrams/architecture-overview.png)

## 🧠 Core concepts

### Module
A single tool definition.

### Profile
A collection of modules grouped by purpose.

### Custom
Local-only overrides:

```text
custom/modules/
custom/profiles/
```

## 📕 Framework, not Distribution

StartKit is a **framework for environment setup**, not a distribution of opinionated tools.

The main value of this repository is:

- the CLI
- module/profile contracts
- runners and validation
- platform and package-manager abstraction
- local extensibility via `custom/`

StartKit intentionally ships with only a **minimal set of reference modules and profiles**.

### Reference modules in core

- `example`
- `git`
- `homebrew`
- `winget`
- `scoop`

### Reference profiles in core

- `base`
- `macos-bootstrap`
- `windows-bootstrap`

These exist to demonstrate how StartKit works, not to define a universal recommended toolset.

> StartKit is a framework, not a distribution.

## 🖥 Platform support

StartKit currently supports:

- macOS
  - Homebrew
- Windows
  - winget
  - scoop

Linux is intentionally out of scope for now, but the architecture leaves room for future extension.

## 📦 Custom

StartKit core intentionally stays minimal.

If you want practical toolsets such as:
- editor stacks
- AI development tools
- GUI apps

use `custom/`.

### Custom Resolution

StartKit resolves custom modules and profiles using `custom/paths.txt`.

- one entry per line
- relative to `custom/`
- empty lines ignored
- `#` treated as comment

Resolution order:

Modules:
1. custom/<root>/modules/<name>
2. custom/modules/<name>
3. modules/<name>

Profiles:
1. custom/<root>/profiles/<name>
2. custom/profiles/<name>
3. profiles/<name>

### Creating Modules / Profiles

```bash
start-kit new module foo
start-kit new profile bar
```

→ custom/modules / custom/profiles

```bash
start-kit new module foo --custom StartKit
```

→ modules/

```bash
start-kit new module foo --custom personal
```

→ custom/personal/

If not registered in paths.txt, it will still be created with warning.

## 📖 CLI

```bash
start-kit install module <name> [--version <value>] [--yes] [--dry-run]
start-kit install profile <name> [--yes] [--dry-run]

start-kit doctor
start-kit doctor module <name>
start-kit doctor profile <name>

start-kit list modules
start-kit list profiles

start-kit new module <name>
start-kit new profile <name>

start-kit version
start-kit --version
start-kit -v

start-kit help
```

## 📄 Contracts

### Module contract

```bash
MODULE_NAME=""
MODULE_DESCRIPTION=""
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=()
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("macos" "windows")

MODULE_PACKAGE_BREW=""
MODULE_PACKAGE_WINGET=""
MODULE_PACKAGE_SCOOP=""

check()
plan()
install()
post_install()
doctor()
```

### Profile contract

```bash
PROFILE_NAME=""
PROFILE_DESCRIPTION=""
PROFILE_MODULES=()
OPTIONAL_MODULES=()
```

## ⚠️ Uninstall policy

StartKit does **not** provide a unified uninstall mechanism.

Modules may implement `uninstall()` as an optional extension, but the CLI does not invoke it in v1.

## 🤝 Contributing

Start here:
- [CONTRIBUTING.md](`CONTRIBUTING.md`)
- [docs/cli-spec.md](docs/cli-spec.md)
- [docs/custom-paths.md](docs/custom-paths.md)
- [docs/module-spec.md](docs/module-spec.md)
- [docs/profile-spec.md](docs/profile-spec.md)

Then:
- [docs/platform-design.md](docs/platform-design.md)
- [docs/git-workflow.md](docs/git-workflow.md)
- [docs/changeset-guide.md](docs/changeset-guide.md)
- [docs/changeset-release-flow.md](docs/changeset-release-flow.md)

Optional:
- [docs/practicality-patch.md](docs/practicality-patch.md)

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for release history.

## 📜 License

MIT
