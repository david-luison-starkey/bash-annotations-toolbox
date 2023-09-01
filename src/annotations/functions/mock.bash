#!/usr/bin/env bash

import interfaces/inject.bash

@inject PRE
# Example mock annotation to be used in testing.
# Injects mock() contents into annotated function, ending
# with "return". This prevents the actual function code from running,
# without removing or intercepting it.
#
# Parameter 1: Redirect ${mock_value} output to stdout or /dev/null
# valid values: STDOUT DEV_NULL
#
# Parameter 2: Text to echo
#
# Parameter 3: Return value of mocked function (default value: 0)
mock() {
	local output="${1:-"STDOUT"}"
	local mock_value="${2}"
	local -i return_value=${3:-0}

	if [[ "${output}" == "STDOUT" ]]; then
		echo "${mock_value}"
	elif [[ "${output}" == "DEV_NULL" ]]; then
		echo "${mock_value}" 1>&2 >/dev/null
	fi

	return ${return_value}
}
