#!/usr/bin/env bash

show_help() {
  cat <<'EOF'
StartKit CLI

Usage:
  start-kit init

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
