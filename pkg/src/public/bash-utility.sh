# shellcheck shell=bash

# @description Prints a formatted error message
# @arg $1 name of package
# @arg $2 message
utility.fprint_error () {
	local custom="$1"
	local msg="$2"

	if utility.should_print_color_stderr; then
		printf "\033[1;31m%s (%s):\033[0m %s\n" 'Error' "$custom" "$msg" >&2
	else
		printf "%s (%s): %s\n" 'Error' "$custom" "$msg" >&2
	fi
}

# @description Prints a formated warning message
# @arg $1 name of package
# @arg $2 message
utility.fprint_warn () {
	local custom="$1"
	local msg="$2"

	if utility.should_print_color_stderr; then
		printf "\033[1;33m%s (%s):\033[0m %s\n" 'Warn' "$custom" "$msg" >&2
	else
		printf "%s (%s): %s\n" 'Warn' "$custom" "$msg" >&2
	fi
}

# @description Prints a formated log message
# @arg $1 name of package
# @arg $2 message
utility.fprint_info () {
	local custom="$1"
	local msg="$2"

	if utility.should_print_color_stdout; then
		printf "\033[1;32m%s (%s):\033[0m %s\n" 'Info' "$custom" "$msg"
	else
		printf "%s (%s): %s\n" 'Info' "$custom" "$msg"
	fi
}

utility.format_error() {
	:
}

utility.format_warn() {
	:
}

utility.format_info() {
	:
}

# @description Finds a parent file
# @arg $1 File name
utility.find_parent_file() {
	unset -v REPLY; REPLY=
	utility.util.find_parent -f "$1"
}

# @description Finds a parent directory
utility.find_parent_dir() {
	unset -v REPLY; REPLY=
	utility.util.find_parent -d "$1"
}


# @description Determine if color should be printed to standard output
# @noargs
utility.should_print_color_stdout() {
	utility._should_print_color 1
}

# @description Determine if color should be printed to standard error
# @noargs
utility.should_print_color_stderr() {
	utility._should_print_color 2
}

# @description Gets information from a particular package. If the key does not exist, then the value
# is an empty string
# @arg $1 string The `$BASALT_PACKAGE_DIR` of the caller
# @set directory string The full path to the directory
utility.get_package_info() {
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

# @set REPLY[major] string Major number
# @set REPLY[minor] string Minor number
# @set REPLY[patch] string Patch number
# @set REPLY[prerelease] string Prerelease number
# @set REPLY[buildmetadata] string Build metadata
utility.get_semver() {
	unset -v REPLY
	declare -Ag REPLY=()

	local version_string="$1"
	
	local major="${version_string%%.*}"
	local minor="${version_string#*.}"; minor=${minor%%.*}
	local patch="${version_string#*.}"; patch=${patch#*.}; patch=${patch%%-*}
	local prerelease="${version_string#*-}"; prerelease=${prerelease%+*}
	local buildmetadata="${version_string#*+}"

	local variable_name=
	for variable_name in major minor patch prerelease buildmetadata; do
		local -n variable="$variable_name"

		if [ "$variable" = "$version_string" ]; then
			variable=
		fi
	done; unset -v variable_name
	unset -nv variables

	REPLY[major]=$major
	REPLY[minor]=$minor
	REPLY[patch]=$patch
	REPLY[prerelease]=$prerelease
	REPLY[buildmetadata]=$buildmetadata
}
