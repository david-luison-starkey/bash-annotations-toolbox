#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/interface.bash

@interface FUNCTION PREPOST
# Function that prints a symbol for the length of the terminal before and after
# a function's execution (and relevant stdout/stderr terminal output)
#
# Parameter 1: Symbol colour (default value: green)
#
# Parameter 2: Symbol that will be used to frame an annotated function's stdout/stderr output
# (default value: "-")
function_lines() {
    # Default symbol colour is green
    local colour="${1:-green}"
    # Default symbol is "-"
    local symbol="${2:--}"
    local width=$(tput cols)
    local lines

    local restore=$(echo -en '\001\033[0m\002')
    local red=$(echo -en '\001\033[00;31m\002')
    local green=$(echo -en '\001\033[00;32m\002')
    local yellow=$(echo -en '\001\033[00;33m\002')
    local blue=$(echo -en '\001\033[00;34m\002')
    local magenta=$(echo -en '\001\033[00;35m\002')
    local purple=$(echo -en '\001\033[00;35m\002')
    local cyan=$(echo -en '\001\033[00;36m\002')

    case "${colour}" in
    "restore" | "red" | "green" | "yellow" | "blue" | "magenta" | "purple" | "cyan")
        :
        ;;
    *)
        return 1
        ;;
    esac

    for ((i = 0; i < width; i++)); do
        lines+="${symbol}"
    done

    echo "${!colour}${lines}${restore}"
}
