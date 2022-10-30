# shellcheck shell=bash

utility.cd_push() {
	if pushd "$@" >/dev/null; then :; else
		return $?
	fi
}

utility.cd_pop() {
	if popd "$@" >/dev/null; then :; else
		return $?
	fi
}