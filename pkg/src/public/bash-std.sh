# shellcheck shell=bash

# @description Finds a parent file
# @arg $1 File name
std.find_parent_file() {
	unset -v REPLY; REPLY=
	std.util.find_parent -f "$1"
}

# @description Finds a parent directory
std.find_parent_dir() {
	unset -v REPLY; REPLY=
	std.util.find_parent -d "$1"
}

# @description Determine if color should be printed. Note that this doesn't
# use tput because simple environment variable checking heuristics suffice
std.should_output_color() {
	# https://no-color.org
	if [ ${NO_COLOR+x} ]; then
		return 1
	fi

	# FIXME
	# # 0 => 2 colors
	# # 1 => 16 colors
	# # 2 => 256 colors
	# # 3 => 16,777,216 colors
	# if [[ -v FORCE_COLOR ]]; then
	# 	return 0
	# fi

	if [ "$COLORTERM" = "truecolor" ] || [ "$COLORTERM" = "24bit" ]; then
		return 0
	fi

	if [ "$TERM" = 'dumb' ]; then
		return 1
	fi

	if [ -t 0 ]; then
		return 0
	fi

	return 1
}

# @description Gets information from a particular package. If the key does not exist, then the value
# is an empty string
# @arg $1 string The `$BASALT_PACKAGE_DIR` of the caller
# @set directory string The full path to the directory
std.get_package_info() {
	unset REPLY; REPLY=
	local basalt_package_dir="$1"
	local key_name="$2"
	
	local toml_file="$basalt_package_dir/basalt.toml"

	if [ ! -f "$toml_file" ]; then
		core.panic "File '$toml_file' could not be found"
	fi

	local regex=$'^[ \t]*'"${key_name}"$'[ \t]*=[ \t]*[\'"](.*)[\'"]'
	while IFS= read -r line || [ -n "$line" ]; do
		if [[ $line =~ $regex ]]; then
			REPLY=${BASH_REMATCH[1]}
			break
		fi
	done < "$toml_file"; unset -v line
}

