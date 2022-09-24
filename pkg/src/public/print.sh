# shellcheck shell=bash

utility.print_auto() {
	:
}

utility.print_array() {
	local flag_oneline='no'

	for arg; do case "$arg" in
		--oneline|-o) flag_oneline='yes';;
	esac done

	local var="$1"

	if declare -p "$var" &>/dev/null; then
		local str=
		if [ "$flag_oneline" = yes ]; then
			:
		elif [ "$flag_oneline" = no ]; then
			:
		fi
	else
		# TODO
		die
	fi
}

utility.print_object() {
	local var="$1"

	if declare -p "$var" &>/dev/null; then
		:
	else
		# TODO
		die
	fi
}
