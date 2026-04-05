#!/usr/bin/env bash

init_custom_layout() {
  mkdir -p "${START_KIT_ROOT}/custom/modules"
  mkdir -p "${START_KIT_ROOT}/custom/profiles"

  local file="${START_KIT_ROOT}/custom/paths.txt"
  if [[ -f "$file" ]]; then
    log_warn "custom/paths.txt already exists"
    return 0
  fi

  cat > "$file" <<'EOF'
# StartKit custom search order
# Top to bottom = higher priority
# Each entry is resolved under custom/
#
# Examples:
# personal
# project-foo
# company/shared
EOF

  log_ok "created custom/paths.txt"
}
