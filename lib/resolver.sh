#!/usr/bin/env bash
resolve_module() {
  local name="$1"
  [[ -f "${START_KIT_ROOT}/custom/modules/${name}/module.sh" ]] && { echo "${START_KIT_ROOT}/custom/modules/${name}/module.sh"; return 0; }
  [[ -f "${START_KIT_ROOT}/modules/${name}/module.sh" ]] && { echo "${START_KIT_ROOT}/modules/${name}/module.sh"; return 0; }
  return 1
}
resolve_profile() {
  local name="$1"
  [[ -f "${START_KIT_ROOT}/custom/profiles/${name}.sh" ]] && { echo "${START_KIT_ROOT}/custom/profiles/${name}.sh"; return 0; }
  [[ -f "${START_KIT_ROOT}/profiles/${name}.sh" ]] && { echo "${START_KIT_ROOT}/profiles/${name}.sh"; return 0; }
  return 1
}
