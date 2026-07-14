#!/usr/bin/env bash
##############################################################################
#
# Script: init-readme.sh
#
# Description:
#   Create or refresh a standardized README.md inside one or more directories.
#
# Usage:
#   init-readme.sh DIRECTORY [DIRECTORY ...]
#
##############################################################################

set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_NAME

usage() {
    cat <<USAGE
Usage:
  $SCRIPT_NAME DIRECTORY [DIRECTORY ...]

Example:
  $SCRIPT_NAME 08-Canonical-Knowledge 09-Architecture
USAGE
}

write_readme() {
    local directory=$1
    local readme_path="$directory/README.md"
    local title
    local today

    if [[ ! -d "$directory" ]]; then
        printf 'ERROR: directory not found: %s\n' "$directory" >&2
        return 1
    fi

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
    local directory

    if (($# == 0)); then
        usage
        exit 1
    fi

    for directory in "$@"; do
        write_readme "$directory"
    done
}

main "$@"
