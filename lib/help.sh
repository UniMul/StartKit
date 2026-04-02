#!/usr/bin/env bash
show_help() {
  cat <<'EOF'
StartKit CLI

Usage:
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
EOF
}
