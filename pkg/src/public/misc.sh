# shellcheck shell=bash

utility.misc_is_exported() {
	local variable_name="$1"

	if (( BASH_VERSINFO[0] > 4 )) || (( BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] >= 4 )); then
		local -n variable="$variable_name"
		if [[ "${variable@a}" == *x* ]]; then
			return 0
		else
			return 1
		fi
	else
		local output=
		output="$(declare -p "$variable_name")"

		case "$output" in
			"declare -x $variable_name"=*) return 0 ;;
		esac

		return 1

		# if declare -x | while read -r line; do
		# 	case "$line" in
		# 		"declare -x $variable_name"=*) return 10 ;;
		# 	esac
		# done; then
		# 	return 1
		# else
		# 	if (($? == 10)); then
		# 		return 0
		# 	else
		# 		return 1
		# 	fi
		# fi
	fi
}

utility.misc_get_type() {
	unset REPLY; REPLY=

	local variable_name="$1"

	# local result=
	# if ! result="$(declare -p "$variable_name" 2>/dev/null)"; then
	# 	echo "Variable not found"
	# 	return
	# fi

	# case "${result:9:1}" in
	# 	A)
	# 		REPLY='object'
	# 		return
	# 		;;
	# 	a)
	# 		REPLY='array'
	# 		return
	# 		;;
	# 	i)
	# 		REPLY='integer'
	# 		return
	# 		;;
	# 	-)
	# 		REPLY='string'
	# 		return
	# 		;;
	# 	*)
	# 		REPLY='other'
	# 		return
	# 		;;
	# esac

	local result="${!variable_name@A}"
	if [ -z "$result" ]; then
		echo "Variable not found"
		return 2
	fi

	if [[ "${result::9}" != 'declare -' ]]; then
		REPLY='string'
		return
	fi

	case "${result:9:1}" in
		A)
			REPLY='object'
			return
			;;
		a)
			REPLY='array'
			return
			;;
		i)
			REPLY='integer'
			return
			;;
		*)
			REPLY='other'
			return
			;;
	esac
}
