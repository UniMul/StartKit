# Custom Path Resolution

StartKit uses `custom/paths.txt` to define the custom search order.

## File format

- one entry per line
- relative to `custom/`
- empty lines are ignored
- lines starting with `#` are treated as comments

Example:

```text
# higher priority first
personal
project-foo
company/shared
```

## Resolution order

### Modules
1. `custom/<paths.txt entry>/modules/<name>/module.sh`
2. `custom/modules/<name>/module.sh`
3. `modules/<name>/module.sh`

### Profiles
1. `custom/<paths.txt entry>/profiles/<name>.sh`
2. `custom/profiles/<name>.sh`
3. `profiles/<name>.sh`

## Creating modules and profiles

### Default behavior
If `--custom` is omitted, StartKit creates under:

- modules -> `custom/modules/<name>/`
- profiles -> `custom/profiles/<name>.sh`

### `--custom default`
Equivalent to omitting `--custom`.

### `--custom StartKit`
Creates in the core repository:

- modules -> `modules/<name>/`
- profiles -> `profiles/<name>.sh`

### `--custom <root>`
Creates under:

- modules -> `custom/<root>/modules/<name>/`
- profiles -> `custom/<root>/profiles/<name>.sh`

If `<root>` is not listed in `custom/paths.txt`, StartKit still creates it, but shows a warning.

## mkdir -p behavior

When creating modules or profiles, StartKit automatically creates missing parent directories.

Examples:
- `modules/`
- `profiles/`
- `custom/modules/`
- `custom/profiles/`
- `custom/<root>/modules/`
- `custom/<root>/profiles/`

## init

`start-kit init` creates:

- `custom/modules/`
- `custom/profiles/`
- `custom/paths.txt`
