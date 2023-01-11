#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/interface.bash

@interface VARIABLE PRE
unique() {
    # shellcheck disable=SC2154
    local -n target="${annotated_variable}"

    # @unique only targets arrays
    if ! [[ $(declare -p "${!target}" 2>/dev/null) =~ "-a" ]]; then
        return 1
    fi

    # shellcheck disable=SC2207
    # https://stackoverflow.com/a/31038481
    target=($(echo "${target[@]}" | tr [:space:] '\n' | awk '!a[$0]++'))
}
