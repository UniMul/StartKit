#!/usr/bin/env bash
set -euo pipefail

START_KIT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=SC1091
source "${START_KIT_ROOT}/lib/log.sh"
source "${START_KIT_ROOT}/lib/common.sh"
source "${START_KIT_ROOT}/lib/platform.sh"

detect_platform
detect_default_package_manager

log_info "StartKit package manager smoke test runner"
log_info "platform=${START_KIT_PLATFORM}"
log_info "package_manager=${START_KIT_PM}"

case "${START_KIT_PLATFORM}" in
  macos)
    if command_exists brew; then
      log_ok "brew command exists"
      brew --version | head -n1
      brew list >/dev/null 2>&1 && log_ok "brew list succeeded"
      brew config >/dev/null 2>&1 && log_ok "brew config succeeded"
    else
      log_error "brew command not found"
      exit 1
    fi
    ;;
  windows)
    runner_ok=false

    if command_exists winget; then
      log_ok "winget command exists"
      winget --version || true
      winget list >/dev/null 2>&1 && log_ok "winget list succeeded"
      runner_ok=true
    else
      log_warn "winget command not found"
    fi

    if command_exists scoop; then
      log_ok "scoop command exists"
      scoop --version || true
      scoop list >/dev/null 2>&1 && log_ok "scoop list succeeded"
      runner_ok=true
    else
      log_warn "scoop command not found"
    fi

    if [[ "${runner_ok}" != "true" ]]; then
      log_error "Neither winget nor scoop is available"
      exit 1
    fi
    ;;
  *)
    log_error "Unsupported platform for this runner: ${START_KIT_PLATFORM}"
    exit 1
    ;;
esac

log_ok "Package manager smoke test completed"
