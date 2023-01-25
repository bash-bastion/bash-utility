# shellcheck shell=bash

utility.find_parent() {
	# shellcheck disable=SC1007
	local op="$1"
	local file="$2"
	
	if REPLY=$(
		# shellcheck disable=SC1072,SC1073,SC1009
		while [ ! "$op" "$file" ] && [ "$PWD" != / ]; do
			if ! cd ..; then
				exit 1
			fi
		done
		if [ "$PWD" = / ]; then
			exit 0
		fi
		printf '%s' "$PWD"
	); then :; else
		panic 'Failed to cd'
	fi
}

utility._should_print_color() {
	local fd="$1"

	if [[ ${NO_COLOR+x} || "$TERM" = 'dumb' ]]; then
		return 1
	fi

	if [ -t "$fd" ]; then
		return 0
	fi

	return 1
}

utility._xdg_get() {
	unset REPLY; REPLY=

	local env_variable="$1"
	local default_value="$2"

	# Use the default value of the environment variable if:
	# - it is unset/empty (handled by the callee)
	# - not an absolute path
	if [ "${env_variable::1}" != '/' ]; then
		REPLY="$default_value"
	else
		REPLY="$env_variable"
	fi
}