#!/usr/bin/env bash

profile_reset_context() {
  unset PROFILE_NAME PROFILE_DESCRIPTION PROFILE_MODULES OPTIONAL_MODULES
}

profile_load() {
  local profile_name="$1"
  local profile_path
  profile_path="$(resolve_profile "$profile_name")" || fail "profile not found: ${profile_name}"

  # shellcheck disable=SC1090
  source "$profile_path"

  PROFILE_NAME="${PROFILE_NAME:-$profile_name}"
  PROFILE_DESCRIPTION="${PROFILE_DESCRIPTION:-}"

  if [[ "$(declare -p PROFILE_MODULES 2>/dev/null || true)" != declare\ -a* ]]; then
    PROFILE_MODULES=()
  fi

  if [[ "$(declare -p OPTIONAL_MODULES 2>/dev/null || true)" != declare\ -a* ]]; then
    OPTIONAL_MODULES=()
  fi
}

run_profile_install() {
  local profile_name="$1"
  local assume_yes="${2:-false}"
  local dry_run="${3:-false}"

  profile_load "$profile_name"

  local installed_modules=()
  local module_name

  log_info "Installing profile: ${PROFILE_NAME}"
  [[ -n "${PROFILE_DESCRIPTION}" ]] && log_info "${PROFILE_DESCRIPTION}"

  for module_name in "${PROFILE_MODULES[@]}"; do
    run_module_install "$module_name" "" installed_modules "$assume_yes" "$dry_run"
  done

  if [[ ${#OPTIONAL_MODULES[@]} -gt 0 ]]; then
    log_info "Optional modules:"
    printf '  - %s\n' "${OPTIONAL_MODULES[@]}"
  fi
}