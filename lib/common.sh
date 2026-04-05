#!/usr/bin/env bash

fail() {
  log_error "$*"
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

read_version() {
  if [[ -f "${START_KIT_ROOT}/package.json" ]]; then
    if command -v node >/dev/null 2>&1; then
      node -p "require('${START_KIT_ROOT}/package.json').version" 2>/dev/null || echo "unknown"
    else
      # fallback: grepで抽出
      grep -m1 '"version"' "${START_KIT_ROOT}/package.json" | sed -E 's/.*"version": *"([^"]+)".*/\1/' || echo "unknown"
    fi
  else
    echo "unknown"
  fi
}

array_contains() {
  local needle="$1"
  shift || true
  local item
  for item in "$@"; do
    [[ "$item" == "$needle" ]] && return 0
  done
  return 1
}