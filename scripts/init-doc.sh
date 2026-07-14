#!/usr/bin/env bash
##############################################################################
#
# Script: init-doc.sh
#
# Description:
#   Create a standardized Markdown document inside a target directory.
#
# Usage:
#   init-doc.sh DIRECTORY DOCUMENT-NAME [TITLE]
#
##############################################################################

set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_NAME

usage() {
    cat <<USAGE
Usage:
  $SCRIPT_NAME DIRECTORY DOCUMENT-NAME [TITLE]

Examples:
  $SCRIPT_NAME 09-Architecture Context-Broker
  $SCRIPT_NAME 08-Canonical-Knowledge Objective-Function "Objective Function"
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
    local directory
    local document_name
    local filename
    local title
    local output_path
    local today

    if (($# < 2 || $# > 3)); then
        usage
        exit 1
    fi

    directory=$1
    document_name=$2

    if [[ ! -d "$directory" ]]; then
        printf 'ERROR: directory not found: %s\n' "$directory" >&2
        exit 1
    fi

    filename=$(normalize_filename "$document_name")
    output_path="$directory/$filename"

    if [[ -e "$output_path" ]]; then
        printf 'ERROR: file already exists: %s\n' "$output_path" >&2
        exit 1
    fi

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
