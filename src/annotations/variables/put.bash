#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/interface.bash

@interface VARIABLE POST
put() {
    local -n nameref_associative_array="${1}"
    # shellcheck disable=SC2154
    nameref_associative_array["${annotated_variable}"]+="${!annotated_variable}"
}
