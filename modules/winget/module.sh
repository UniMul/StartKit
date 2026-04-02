#!/usr/bin/env bash
MODULE_NAME="winget"
MODULE_DESCRIPTION="Windows Package Manager"
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=()
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("windows")
MODULE_PACKAGE_BREW=""
MODULE_PACKAGE_WINGET=""
MODULE_PACKAGE_SCOOP=""
check() { command_exists winget; }
plan() { log_info "Validate winget availability"; }
install() { log_warn "winget is expected to be available on supported Windows environments"; return 0; }
post_install() { :; }
doctor() { command_exists winget || return 1; return 0; }
