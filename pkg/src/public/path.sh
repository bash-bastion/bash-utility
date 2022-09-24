# shellcheck shell=bash

utility.path_append() {
	[ -n "$2" ] && {
	case ":$(eval "echo \$$1"):" in
		*":$2:"*) :;;
		*) eval "export $1=\${$1:+\"\$$1:\"}$2"
		;;
	esac;
	return
	};
	
	case ":$PATH:" in
		*":$1:"*) : ;;
		*) export PATH="${PATH:+"$PATH:"}$1" ;;
	esac
}

utility.path_prepend() {
	[ -n "$2" ] && {
	case ":$(eval "echo \$$1"):" in
		*":$2:"*) : ;;
		*) eval "export $1=$2\${$1:+\":\$$1\"}" ;;
	esac;
	return
	};
	case ":$PATH:" in
	*":$1:"*)
		:
	;;
	*)
		export PATH="$1${PATH:+":$PATH"}"
	;;
	esac
}
