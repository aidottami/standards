\
#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_NAME

usage() {
    cat <<USAGE
Usage:
  $SCRIPT_NAME DIRECTORY DOCUMENT-NAME [TITLE]
USAGE
}

normalize_filename() {
    local value=$1
    value=${value%.md}
    value=${value// /-}
    printf '%s.md\n' "$value"
}

title_from_filename() {
    local value=$1
    value=${value%.md}
    value=${value//-/ }
    printf '%s\n' "$value"
}

main() {
    (($# >= 2 && $# <= 3)) || {
        usage
        exit 1
    }

    local directory=$1
    local document_name=$2
    local filename
    local title
    local output_path
    local today

    [[ -d "$directory" ]] || {
        printf 'ERROR: directory not found: %s\n' "$directory" >&2
        exit 1
    }

    filename=$(normalize_filename "$document_name")
    output_path="$directory/$filename"

    [[ ! -e "$output_path" ]] || {
        printf 'ERROR: file already exists: %s\n' "$output_path" >&2
        exit 1
    }

    if (($# == 3)); then
        title=$3
    else
        title=$(title_from_filename "$filename")
    fi

    today=$(date +%F)

    cat >"$output_path" <<EOF
# $title

## Purpose

TODO

## Definition

TODO

## Scope

TODO

## Contents

TODO

## Status

Draft

## Last updated

$today
EOF

    printf 'Created: %s\n' "$output_path"
}

main "$@"
