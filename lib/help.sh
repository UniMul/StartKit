#!/usr/bin/env bash

show_help() {
  cat <<'EOF'
StartKit CLI

Usage:
  start-kit init

  start-kit install module <name> [--version <value>] [--yes] [--dry-run]
  start-kit install profile <name> [--yes] [--dry-run]

  start-kit doctor
  start-kit doctor module <name>
  start-kit doctor profile <name>

  start-kit list modules
  start-kit list profiles

  start-kit new module <name> [--custom <root>]
  start-kit new profile <name> [--custom <root>]

  start-kit version
  start-kit --version
  start-kit -v

Special custom roots:
  default   -> custom/modules or custom/profiles
  StartKit  -> modules or profiles
EOF
}