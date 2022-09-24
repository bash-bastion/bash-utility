# shellcheck shell=bash

task.docs() {
	shdoc './pkg/src/public/bash-utility.sh' > './docs/reference.md'
}