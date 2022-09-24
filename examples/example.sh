# shellcheck shell=bash

for f in ./pkg/src/{public,util}/*.sh; do
	# shellcheck disable=SC1090
	source "$f"
done; unset -v f

utility.fprint_info 'hookah' 'other'