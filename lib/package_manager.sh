#!/usr/bin/env bash
module_package_name_for_current_pm() {
  case "${START_KIT_PM}" in
    brew) echo "${MODULE_PACKAGE_BREW:-}" ;;
    winget) echo "${MODULE_PACKAGE_WINGET:-}" ;;
    scoop) echo "${MODULE_PACKAGE_SCOOP:-}" ;;
    *) echo "" ;;
  esac
}
pm_check_ready() {
  case "${START_KIT_PM}" in
    brew) command_exists brew ;;
    winget) command_exists winget ;;
    scoop) command_exists scoop ;;
    *) return 1 ;;
  esac
}
pm_install_package() {
  local pkg="$1"
  case "${START_KIT_PM}" in
    brew) brew install "$pkg" ;;
    winget) winget install --id "$pkg" -e --accept-package-agreements --accept-source-agreements ;;
    scoop) scoop install "$pkg" ;;
    *) log_error "Unsupported package manager: ${START_KIT_PM}"; return 1 ;;
  esac
}
pm_install_module_package() {
  local pkg
  pkg="$(module_package_name_for_current_pm)"
  [[ -n "$pkg" ]] || { log_error "No package mapping for module '${MODULE_NAME}' on package manager '${START_KIT_PM}'"; return 1; }
  pm_install_package "$pkg"
}
