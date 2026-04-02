#!/usr/bin/env bash
doctor_core() {
  log_ok "start-kit version: $(read_version)"
  log_ok "platform: ${START_KIT_PLATFORM}"
  [[ -n "${START_KIT_PM}" ]] && log_ok "package manager: ${START_KIT_PM}" || log_warn "package manager not selected"
  if pm_check_ready; then log_ok "package manager command available"; else log_warn "package manager command not available"; fi
}
doctor_module() { local module_name="$1"; module_load "$module_name"; doctor; }
doctor_profile() { local profile_name="$1"; profile_load "$profile_name"; local module_name; for module_name in "${PROFILE_MODULES[@]}"; do doctor_module "$module_name"; done; }
