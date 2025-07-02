#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

get_weather() {
  local location=$(get_tmux_option "@tmux-weather-location")
  local format=$(get_tmux_option "@tmux-weather-format" 1)
  local units=$(get_tmux_option "@tmux-weather-units" "m")
  local gps=$(get_tmux_option "@tmux-weather-gps" "false")

  if [[ "$gps" == "true" ]]; then
    if [[ "$(uname)" == "Darwin" ]]; then
      if gps=$(CoreLocationCLI --format "%latitude,%longitude"); then
        location="$gps";
      fi

    elif [[ "$(uname)" == "Linux" ]]; then
      echo "GPS on Linux not yet supported!"
    fi
  fi

  if [ "$units" != "m" ] && [ "$units" != "u" ]; then
    units="m"
  fi

  curl -s "https://wttr.in/$location?$units&format=$format" | sed "s/[[:space:]]km/km/g"
}

main() {
  local update_interval=$((60 * $(get_tmux_option "@tmux-weather-interval" 15)))
  local current_time=$(date "+%s")
  local previous_update=$(get_tmux_option "@weather-previous-update-time")
  local delta=$((current_time - previous_update))

  if [ -z "$previous_update" ] || [ $delta -ge $update_interval ]; then
    local value=$(get_weather)
    if [ "$?" -eq 0 ]; then
      $(set_tmux_option "@weather-previous-update-time" "$current_time")
      $(set_tmux_option "@weather-previous-value" "$value")
    fi
  fi

  echo -n $(get_tmux_option "@weather-previous-value")
}

main
