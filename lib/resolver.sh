#!/usr/bin/env bash

read_custom_roots() {
  local file="${START_KIT_ROOT}/custom/paths.txt"

  [[ -f "$file" ]] || return 0

  while IFS= read -r line; do
    line="$(printf '%s' "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    [[ -z "$line" ]] && continue
    [[ "$line" =~ ^# ]] && continue
    printf '%s\n' "$line"
  done < "$file"
}

resolve_module() {
  local name="$1"
  local root
  local candidate

  while IFS= read -r root; do
    candidate="${START_KIT_ROOT}/custom/${root}/modules/${name}/module.sh"
    if [[ -f "$candidate" ]]; then
      echo "$candidate"
      return 0
    fi
  done < <(read_custom_roots)

  candidate="${START_KIT_ROOT}/custom/modules/${name}/module.sh"
  if [[ -f "$candidate" ]]; then
    echo "$candidate"
    return 0
  fi

  candidate="${START_KIT_ROOT}/modules/${name}/module.sh"
  if [[ -f "$candidate" ]]; then
    echo "$candidate"
    return 0
  fi

  return 1
}

resolve_profile() {
  local name="$1"
  local root
  local candidate

  while IFS= read -r root; do
    candidate="${START_KIT_ROOT}/custom/${root}/profiles/${name}.sh"
    if [[ -f "$candidate" ]]; then
      echo "$candidate"
      return 0
    fi
  done < <(read_custom_roots)

  candidate="${START_KIT_ROOT}/custom/profiles/${name}.sh"
  if [[ -f "$candidate" ]]; then
    echo "$candidate"
    return 0
  fi

  candidate="${START_KIT_ROOT}/profiles/${name}.sh"
  if [[ -f "$candidate" ]]; then
    echo "$candidate"
    return 0
  fi

  return 1
}

is_custom_root_registered() {
  local root="$1"
  [[ "$root" == "default" ]] && return 0
  [[ "$root" == "StartKit" ]] && return 0

  local item
  while IFS= read -r item; do
    [[ "$item" == "$root" ]] && return 0
  done < <(read_custom_roots)

  return 1
}
