#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/interface.bash

@interface VARIABLE POST
# Annotate a variable to have it put into an associative array
# when called.
#
# The key is the variable name.
#
# The value is the variable value.
#
# If a variable is called multiple times then the key value pair
# is overwritten with the latest value.
#
# Multiple variables can be annotated to be added to the same
# associative array
#
# Parameter 1: Associative array passed by name
#
# e.g.: declare -A MAP; @put MAP
#
# NOT
#
# declare -A MAP; @put "${MAP}"
put() {
    local -n nameref_associative_array="${1}"
    local argument_type=$(declare -p "${!nameref_associative_array}" 2>/dev/null)

    # @put only accepts associative arrays
    if ! [[ "${argument_type%%\=*}" =~ "-A" ]]; then
        return 1
    fi
    # shellcheck disable=SC2154
    nameref_associative_array["${annotated_variable}"]+="${!annotated_variable}"
}
