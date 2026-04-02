#!/usr/bin/env bash
START_KIT_PLATFORM=""
START_KIT_PM=""
detect_platform() {
  case "$(uname -s)" in
    Darwin) START_KIT_PLATFORM="macos" ;;
    MINGW*|MSYS*|CYGWIN*) START_KIT_PLATFORM="windows" ;;
    *) START_KIT_PLATFORM="unknown" ;;
  esac
  export START_KIT_PLATFORM
}
detect_default_package_manager() {
  case "${START_KIT_PLATFORM}" in
    macos) START_KIT_PM="${START_KIT_PM:-brew}" ;;
    windows) START_KIT_PM="${START_KIT_PM:-winget}" ;;
    *) START_KIT_PM="" ;;
  esac
  export START_KIT_PM
}
ensure_supported_platform() {
  local supported=("$@")
  array_contains "${START_KIT_PLATFORM}" "${supported[@]}"
}
