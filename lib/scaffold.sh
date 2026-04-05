#!/usr/bin/env bash

resolve_creation_target() {
  local kind="$1"
  local name="$2"
  local custom_root="${3:-default}"

  case "$custom_root" in
    ""|default)
      if [[ "$kind" == "module" ]]; then
        TARGET_DIR="${START_KIT_ROOT}/custom/modules/${name}"
        TARGET_FILE="${TARGET_DIR}/module.sh"
        TARGET_MANUAL_DIR="${TARGET_DIR}/manual"
      else
        TARGET_DIR="${START_KIT_ROOT}/custom/profiles"
        TARGET_FILE="${TARGET_DIR}/${name}.sh"
        TARGET_MANUAL_DIR=""
      fi
      ;;
    StartKit)
      if [[ "$kind" == "module" ]]; then
        TARGET_DIR="${START_KIT_ROOT}/modules/${name}"
        TARGET_FILE="${TARGET_DIR}/module.sh"
        TARGET_MANUAL_DIR="${TARGET_DIR}/manual"
      else
        TARGET_DIR="${START_KIT_ROOT}/profiles"
        TARGET_FILE="${TARGET_DIR}/${name}.sh"
        TARGET_MANUAL_DIR=""
      fi
      ;;
    *)
      if ! is_custom_root_registered "$custom_root"; then
        log_warn "custom root '${custom_root}' is not listed in custom/paths.txt"
      fi

      if [[ "$kind" == "module" ]]; then
        TARGET_DIR="${START_KIT_ROOT}/custom/${custom_root}/modules/${name}"
        TARGET_FILE="${TARGET_DIR}/module.sh"
        TARGET_MANUAL_DIR="${TARGET_DIR}/manual"
      else
        TARGET_DIR="${START_KIT_ROOT}/custom/${custom_root}/profiles"
        TARGET_FILE="${TARGET_DIR}/${name}.sh"
        TARGET_MANUAL_DIR=""
      fi
      ;;
  esac
}

new_module() {
  local name="$1"
  local custom_root="${2:-default}"

  resolve_creation_target "module" "$name" "$custom_root"

  [[ ! -e "$TARGET_DIR" ]] || fail "module already exists: ${name}"

  mkdir -p "$TARGET_MANUAL_DIR"

  cat > "$TARGET_FILE" <<EOF
#!/usr/bin/env bash

MODULE_NAME="${name}"
MODULE_DESCRIPTION="${name} module"
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=(
  "manual/install.md"
)
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("macos" "windows")

MODULE_PACKAGE_BREW="${name}"
MODULE_PACKAGE_WINGET=""
MODULE_PACKAGE_SCOOP="${name}"

check() {
  return 1
}

plan() {
  log_info "Install \${MODULE_NAME}"
}

install() {
  pm_install_module_package
}

post_install() {
  :
}

doctor() {
  check || return 1
  return 0
}
EOF

  cat > "${TARGET_MANUAL_DIR}/install.md" <<EOF
# ${name} manual

Write manual steps for ${name} here.
EOF

  chmod +x "$TARGET_FILE"
  log_ok "created module: ${TARGET_DIR}"
}

new_profile() {
  local name="$1"
  local custom_root="${2:-default}"

  resolve_creation_target "profile" "$name" "$custom_root"

  [[ ! -e "$TARGET_FILE" ]] || fail "profile already exists: ${name}"

  mkdir -p "$TARGET_DIR"

  cat > "$TARGET_FILE" <<EOF
#!/usr/bin/env bash

PROFILE_NAME="${name}"
PROFILE_DESCRIPTION="${name} profile"

PROFILE_MODULES=(
)

OPTIONAL_MODULES=(
)
EOF

  chmod +x "$TARGET_FILE"
  log_ok "created profile: ${TARGET_FILE}"
}
