#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/interface.bash

@interface VARIABLE PRE
regex_typing() {
    local pattern="${1}"
    # shellcheck disable=SC2154
    local target="${annotated_variable}"

    if [[ "${!target}" =~ ${pattern} ]]; then
        return 0
    else
        return 1
    fi
}
