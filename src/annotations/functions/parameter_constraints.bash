#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/inject.bash

@inject PRE
# Example annotation of how arguments can be checked for an annotated 
# function to ensure they conform to pre-defined constraints.
#
# Parameter 1: Number of expected arguments (this example expects three as per switch statement)
parameter_constraints() {
    local expected_number_args="${1}"
    # Counter-intuitively, the annotated function's number of args is not escaped,
    # while the positional arguments array is (see for loop below)
    local annotated_function_number_args="${#@}"

    if [[ "${expected_number_args}" -ne "${annotated_function_number_args}" ]]; then
        echo -n "[ERROR] @parameter_constraints -> ${FUNCNAME[0]}(): ${BASH_LINENO[0]} - "
        echo "expected ${expected_number_args} arguments but received ${annotated_function_number_args}"
        return 1
    fi

    # Use counter with for loop to check positional arguments against expected values
    local arg_counter=0

    for arg in "\\\${@}"; do
        ((arg_counter++))
        case "${arg_counter}" in
            1)
                if ! grep -P "\b\D+\b" < <(echo "${arg}") 1>&2 > /dev/null; then
                    echo -n "[ERROR] @parameter_constraints -> ${FUNCNAME[0]}(): ${BASH_LINENO[0]} - "
                    echo "First argument ${arg} is not a word"
                    return 1 
                fi
            ;;
            2)
                if [[ ! -d "${arg}" ]]; then
                    echo -n "[ERROR] @parameter_constraints -> ${FUNCNAME[0]}(): ${BASH_LINENO[0]} - "
                    echo "Second argument ${arg} is not an extant directory"
                    return 1
                fi
            ;;
            3)
                if [[ ! -x "${arg}" ]]; then 
                    echo -n "[ERROR] @parameter_constraints -> ${FUNCNAME[0]}(): ${BASH_LINENO[0]} - "
                    echo "Third argument ${arg} is not executable"
                    return 1
                fi
            ;;
            *)
                echo "[ERROR] @parameter_constraints -> ${FUNCNAME[0]}(): ${BASH_LINENO[0]}"
                return 1 
            ;;
        esac
    done    
}