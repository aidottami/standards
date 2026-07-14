\
#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_NAME

usage() {
    cat <<USAGE
Usage:
  $SCRIPT_NAME DIRECTORY [DIRECTORY ...]
USAGE
}

write_readme() {
    local directory=$1
    local readme_path="$directory/README.md"
    local title
    local today

    [[ -d "$directory" ]] || {
        printf 'ERROR: directory not found: %s\n' "$directory" >&2
        return 1
    }

    title=$(basename "$directory")
    today=$(date +%F)

    cat >"$readme_path" <<EOF
# $title

## Purpose

TODO

## Contents

- TODO

## Status

Draft

## Last updated

$today
EOF

    printf 'Created: %s\n' "$readme_path"
}

main() {
    (($# > 0)) || {
        usage
        exit 1
    }

    local directory
    for directory in "$@"; do
        write_readme "$directory"
    done
}

main "$@"
