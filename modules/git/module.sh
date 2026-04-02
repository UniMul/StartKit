#!/usr/bin/env bash
MODULE_NAME="git"
MODULE_DESCRIPTION="Git version control"
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=()
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("macos" "windows")
MODULE_PACKAGE_BREW="git"
MODULE_PACKAGE_WINGET="Git.Git"
MODULE_PACKAGE_SCOOP="git"
check() { command_exists git; }
plan() { log_info "Install git via ${START_KIT_PM}"; }
install() { pm_install_module_package; }
post_install() { :; }
doctor() { command_exists git || return 1; return 0; }
