#!/usr/bin/env bash
fail() { log_error "$*"; exit 1; }
command_exists() { command -v "$1" >/dev/null 2>&1; }
read_version() { cat "${START_KIT_ROOT}/VERSION" 2>/dev/null || echo "unknown"; }
array_contains() { local needle="$1"; shift || true; local item; for item in "$@"; do [[ "$item" == "$needle" ]] && return 0; done; return 1; }
