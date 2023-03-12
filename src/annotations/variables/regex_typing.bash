#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/interface.bash

@interface VARIABLE PRE
# Affords strong typing for the annotated variable based on
# the provided regex pattern string.
#
# Validations are persistent and will be performed, even if
# the variable has a new value assigned.
#
# Validations are lazy and occur just before a variable is
# called (as per @interface functionality).
#
# Parameter 1: Pattern string
regex_typing() {
    local pattern="${1}"
    # shellcheck disable=SC2154

    # Implement custom logging and error handling here
    if [[ "${annotated_variable_value}" =~ ${pattern} ]]; then
        exit 0
    else
        exit 1
    fi
}
