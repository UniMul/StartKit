#!/usr/bin/env bash
list_modules() {
  local dir results=()
  for dir in "${START_KIT_ROOT}/modules" "${START_KIT_ROOT}/custom/modules"; do
    [[ -d "$dir" ]] || continue
    while IFS= read -r -d '' module_file; do
      local name; name="$(basename "$(dirname "$module_file")")"
      array_contains "$name" "${results[@]:-}" || results+=("$name")
    done < <(find "$dir" -mindepth 2 -maxdepth 2 -type f -name "module.sh" -print0 2>/dev/null)
  done
  printf '%s\n' "${results[@]}" | sort
}
list_profiles() {
  local dir results=()
  for dir in "${START_KIT_ROOT}/profiles" "${START_KIT_ROOT}/custom/profiles"; do
    [[ -d "$dir" ]] || continue
    while IFS= read -r -d '' profile_file; do
      local name; name="$(basename "$profile_file" .sh)"
      array_contains "$name" "${results[@]:-}" || results+=("$name")
    done < <(find "$dir" -mindepth 1 -maxdepth 1 -type f -name "*.sh" -print0 2>/dev/null)
  done
  printf '%s\n' "${results[@]}" | sort
}
