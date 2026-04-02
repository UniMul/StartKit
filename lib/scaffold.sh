#!/usr/bin/env bash
new_module() {
  local name="$1"
  local dir="${START_KIT_ROOT}/modules/${name}"
  mkdir -p "${dir}/manual"
  cat > "${dir}/module.sh" <<EOF
#!/usr/bin/env bash

MODULE_NAME="${name}"
MODULE_DESCRIPTION="${name} module"
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=("manual/install.md")
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("macos" "windows")
MODULE_PACKAGE_BREW="${name}"
MODULE_PACKAGE_WINGET=""
MODULE_PACKAGE_SCOOP="${name}"

check() { return 1; }
plan() { log_info "Install \${MODULE_NAME}"; }
install() { pm_install_module_package; }
post_install() { :; }
doctor() { check || return 1; return 0; }
EOF
  cat > "${dir}/manual/install.md" <<EOF
# ${name} manual
EOF
  chmod +x "${dir}/module.sh"
  log_ok "created module: ${name}"
}
new_profile() {
  local name="$1"
  local path="${START_KIT_ROOT}/profiles/${name}.sh"
  cat > "${path}" <<EOF
#!/usr/bin/env bash
PROFILE_NAME="${name}"
PROFILE_DESCRIPTION="${name} profile"
PROFILE_MODULES=()
OPTIONAL_MODULES=()
EOF
  chmod +x "${path}"
  log_ok "created profile: ${name}"
}
