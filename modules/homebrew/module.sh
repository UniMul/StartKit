#!/usr/bin/env bash
MODULE_NAME="homebrew"
MODULE_DESCRIPTION="Homebrew package manager"
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=()
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("macos")
MODULE_PACKAGE_BREW=""
MODULE_PACKAGE_WINGET=""
MODULE_PACKAGE_SCOOP=""
check() { command_exists brew; }
plan() { log_info "Install Homebrew"; }
install() { /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }
post_install() { :; }
doctor() { command_exists brew || return 1; return 0; }
