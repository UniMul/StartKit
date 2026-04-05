#!/usr/bin/env bash

module_reset_context() {
  unset MODULE_NAME MODULE_DESCRIPTION MODULE_SUPPORTS_VERSION
  unset MODULE_DEPENDS MODULE_MANUAL_DOCS MODULE_SUPPORTED_PLATFORMS
  unset MODULE_PACKAGE_BREW MODULE_PACKAGE_WINGET MODULE_PACKAGE_SCOOP
  unset -f check plan install post_install doctor 2>/dev/null || true
}

module_load() {
  local module_name="$1"
  local module_path
  module_path="$(resolve_module "$module_name")" || fail "module not found: ${module_name}"

  module_reset_context

  # shellcheck disable=SC1090
  source "$module_path"

  MODULE_NAME="${MODULE_NAME:-$module_name}"
  MODULE_DESCRIPTION="${MODULE_DESCRIPTION:-}"
  MODULE_SUPPORTS_VERSION="${MODULE_SUPPORTS_VERSION:-false}"

  declare -f check >/dev/null || fail "module '${module_name}' is missing check()"
  declare -f plan >/dev/null || fail "module '${module_name}' is missing plan()"
  declare -f install >/dev/null || fail "module '${module_name}' is missing install()"
  declare -f post_install >/dev/null || fail "module '${module_name}' is missing post_install()"
  declare -f doctor >/dev/null || fail "module '${module_name}' is missing doctor()"
}

module_is_installed() {
  local module_name="$1"
  module_load "$module_name"
  check
}

collect_missing_dependencies() {
  local module_name="$1"
  local out_name="$2"
  local dep

  module_load "$module_name"

  eval 'for dep in "${MODULE_DEPENDS[@]-}"; do
    if ! array_contains "$dep" "${'"$out_name"'[@]-}"; then
      if ! module_is_installed "$dep"; then
        '"$out_name"'+=("$dep")
      fi
      collect_missing_dependencies "$dep" '"$out_name"'
    fi
  done'
}

confirm_dependency_install() {
  local missing=("$@")

  [[ ${#missing[@]} -eq 0 ]] && return 0

  printf 'The following dependencies will be installed:\n'
  printf ' - %s\n' "${missing[@]}"
  printf 'Proceed? [y/N]: '
  read -r answer
  [[ "$answer" == "y" || "$answer" == "Y" ]]
}

print_dependency_status() {
  local module_name="$1"
  local dep

  module_load "$module_name"

  eval '[[ ${#MODULE_DEPENDS[@]-0} -eq 0 ]]' && return 0

  log_info "Dependencies for ${MODULE_NAME}:"

  eval 'for dep in "${MODULE_DEPENDS[@]-}"; do
    if module_is_installed "$dep"; then
      printf "  [OK] %s\n" "$dep"
    else
      printf "  [MISSING] %s\n" "$dep"
    fi
  done'
}

run_module_install() {
  local module_name="$1"
  local requested_version="${2:-}"
  local installed_ref_name="$3"
  local assume_yes="${4:-false}"
  local dry_run="${5:-false}"

  if eval 'array_contains "$module_name" "${'"$installed_ref_name"'[@]-}"'; then
    return 0
  fi

  local missing_deps=()
  collect_missing_dependencies "$module_name" missing_deps

  if [[ "$dry_run" == "true" ]]; then
    log_info "Dry-run: module ${module_name}"
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
      log_info "Missing dependencies:"
      printf '  - %s\n' "${missing_deps[@]}"
    fi
    module_load "$module_name"
    plan
    return 0
  fi

  if [[ ${#missing_deps[@]} -gt 0 && "$assume_yes" != "true" ]]; then
    confirm_dependency_install "${missing_deps[@]}" || fail "installation cancelled"
  fi

  module_load "$module_name"

  local dep
  eval 'for dep in "${MODULE_DEPENDS[@]-}"; do
    run_module_install "$dep" "" '"$installed_ref_name"' "$assume_yes" "$dry_run"
  done'

  if eval '[[ ${#MODULE_SUPPORTED_PLATFORMS[@]-0} -gt 0 ]]'; then
    eval 'ensure_supported_platform "${MODULE_SUPPORTED_PLATFORMS[@]}"' || {
      log_error "module '${MODULE_NAME}' does not support platform '${START_KIT_PLATFORM}'"
      return 1
    }
  fi

  export START_KIT_VERSION="$requested_version"

  print_dependency_status "$module_name"

  if check; then
    log_ok "${MODULE_NAME} already installed"
  else
    plan
    install
    post_install
  fi

  if doctor; then
    log_ok "${MODULE_NAME} doctor passed"
  else
    local rc=$?
    if [[ "$rc" -eq 2 ]]; then
      log_warn "${MODULE_NAME} doctor returned WARN"
    else
      log_error "${MODULE_NAME} doctor returned FAIL"
      return "$rc"
    fi
  fi

  eval "$installed_ref_name+=(\"\$module_name\")"
}