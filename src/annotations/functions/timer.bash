#!/usr/bin/env bash

# shellcheck disable=SC1091
import interfaces/interface.bash

@interface FUNCTION PREPOST
# Output function runtime in seconds
#
# Parameters: None
timer() {
    declare -gx bash_annotations_timer_start
    declare -gx bash_annotations_timer_end

    if [[ -z "${bash_annotations_timer_start}" ]]; then
        bash_annotations_timer_start=$(date -u +%s.%N)
    elif [[ -n "${bash_annotations_timer_start}" ]]; then
        bash_annotations_timer_end=$(date -u +%s.%N)
        printf "%s() runtime: " "${annotated_function}"
        # Return value as float: https://unix.stackexchange.com/questions/314365/get-elapsed-time-in-bash
        printf "%0.3f seconds\n" "$(bc -q <<<"scale=3; $bash_annotations_timer_end - $bash_annotations_timer_start")"
        # Unset global variables for use by other annotated functions
        unset -v bash_annotations_timer_start
        unset -v bash_annotations_timer_end
    fi
}
