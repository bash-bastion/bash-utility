# shellcheck shell=bash

utility.xdg_get_config_home() {
	utility._xdg_get "${XDG_CONFIG_HOME:-}" "$HOME/.config"
}

utility.xdg_get_data_home() {
	utility._xdg_get "${XDG_DATA_HOME:-}" "$HOME/.local/share"
}

utility.xdg_get_state_home() {
	utility._xdg_get "${XDG_STATE_HOME:-}" "$HOME/.local/state"
}

utility.xdg_get_cache_home() {
	utility._xdg_get "${XDG_CACHE_HOME:-}" "$HOME/.cache"
}