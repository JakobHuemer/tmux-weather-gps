# Weather plugin for tmux
[![GitHub](https://img.shields.io/github/license/JakobHuemer/tmux-weather-gps)](https://opensource.org/licenses/MIT)

Shows weather in the status line, data provided by [wttr.in](https://wttr.in)

![tmux-weather](./assets/tmux-preview.png)

## Installation
### Requirements
* curl
* sed

> **Note for macOS users:**  
> If you want to use the GPS function, you must have [CoreLocationCLI](https://github.com/fulldecent/corelocationcli) installed.

### With Tmux Plugin Manager
Add the plugin in `.tmux.conf`:
```
set -g @plugin 'jakobhuemer/tmux-weather-gps'
```
Press `prefix + I` to fetch the plugin and source it. Done.

### Manual
Clone the repo somewhere. Add `run-shell` in the end of `.tmux.conf`:

```
run-shell PATH_TO_REPO/tmux-weather.tmux
```
NOTE: this line should be placed after `set-option -g status-right ...`.

Press `prefix + :` and type `source-file ~/.tmux.conf`. Done.

## Usage
Add `#{weather}` somewhere in the right status line:
```
set-option -g status-right "#{weather}"
```
then you will see the current weather in the status line: `⛅️ -1°C`

## Customization
The plugin could be customized with:
* `set-option -g @tmux-weather-interval 15` - Set up the update interval in minutes, by default it is 15 minutes.
* `set-option -g @tmux-weather-location "Tomsk"` - Set up your location, by default you will get the weather for your current location based on your IP address.
* `set-option -g @tmux-weather-format "%c+%t+%w"` - Set up a representation, by default it is 1, for more options go to [https://github.com/chubin/wttr.in#one-line-output](https://github.com/chubin/wttr.in#one-line-output)
* `set-option -g @tmux-weather-units" "m"` - Set up weather units (u - for USCS, m - for metric system), by default used metric units.
* `set-option -g @tmux-weather-gps "true"` - Use GPS to determine location (currently only on macOS). If set to true, this will override the configured location. If GPS lookup fails, it will fall back to the set location.

## Other plugins
* [tmux-network-bandwidth](https://github.com/xamut/tmux-network-bandwidth)
* [tmux-spotify](https://github.com/xamut/tmux-spotify)

## License
tmux-weather-gps plugin is released under the [MIT License](https://opensource.org/licenses/MIT).
