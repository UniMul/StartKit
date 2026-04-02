#!/usr/bin/env bash
MODULE_NAME="scoop"
MODULE_DESCRIPTION="Scoop package manager"
MODULE_DEPENDS=()
MODULE_MANUAL_DOCS=()
MODULE_SUPPORTS_VERSION=false
MODULE_SUPPORTED_PLATFORMS=("windows")
MODULE_PACKAGE_BREW=""
MODULE_PACKAGE_WINGET=""
MODULE_PACKAGE_SCOOP=""
check() { command_exists scoop; }
plan() { log_info "Install scoop"; }
install() { powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb get.scoop.sh | iex"; }
post_install() { :; }
doctor() { command_exists scoop || return 1; return 0; }
