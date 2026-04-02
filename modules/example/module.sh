#!/usr/bin/env bash
MODULE_NAME="example"
MODULE_DESCRIPTION="Example module"
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=()
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("macos" "windows")
MODULE_PACKAGE_BREW=""
MODULE_PACKAGE_WINGET=""
MODULE_PACKAGE_SCOOP=""
check() { command_exists bash; }
plan() { log_info "Example module has no install step"; }
install() { log_info "Nothing to install for example module"; }
post_install() { :; }
doctor() { command_exists bash || return 1; return 0; }
