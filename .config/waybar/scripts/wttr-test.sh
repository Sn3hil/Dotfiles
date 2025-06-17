#!/usr/bin/env bash

#!/usr/bin/env bash

# City coordinates
LAT="" #latitude
LON="" #longitude
CITY="" #city name in wttr.in

# Query API.met.no ||| user agent can be anything
DATA=$(curl -s -H "User-Agent: kshiyo@weather" \
  "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$LAT&lon=$LON")

# Parse temp using jq
TEMP=$(echo "$DATA" | jq '.properties.timeseries[0].data.instant.details.air_temperature')

CONDITION=$(echo "$DATA" | jq -r '.properties.timeseries[0].data.next_1_hours.summary.symbol_code')



# Match cleaned condition to Nerd Font icon
case "$CONDITION" in
    "clearsky_day") ICON="" ;;         # ☀️ Sunny
    "clearsky_night") ICON="" ;;       # 🌙 Clear night

    "fair_day") ICON="" ;;             # 🌤 Fair
    "fair_night") ICON="" ;;           # 🌤 Fair night

    "partlycloudy_day") ICON="󰖕" ;;     # ⛅ Partly cloudy
    "partlycloudy_night") ICON="" ;;   # ⛅ Partly cloudy night

    "cloudy") ICON="" ;;               # ☁ Cloudy

    "rainshowers_day") ICON="" ;;      # 🌦 Rain showers (day)
	"heavyrainshowers_night") ICON="" ;;
	"heavyrainshowers_day") ICON="" ;;
"lightrainshowers_night") ICON="" ;;
	"lightrainshowers_day") ICON="" ;;
    "rainshowers_night") ICON="" ;;    # 🌦 Rain showers (night)
    "rainshowersandthunder_day") ICON="" ;;   # ⛈ Thunder + showers
    "rainshowersandthunder_night") ICON="" ;; # ⛈ Thunder + showers (night)

    "heavyrain") ICON="" ;;            # 🌧 Heavy rain
    "heavyrainandthunder") ICON="" ;;  # ⛈ Heavy rain + thunder
    "rain") ICON="" ;;                 # 🌧 Rain
    "lightrain") ICON="" ;;            # 🌧 Light rain
    "lightrainandthunder") ICON="" ;;  # ⛈ Light rain + thunder
    "rainandthunder") ICON="" ;;       # ⛈ Rain + thunder

    "sleet") ICON="" ;;                # 🌧 Sleet
    "heavysleet") ICON="" ;;           # 🌧 Heavy sleet
    "lightsleet") ICON="" ;;           # 🌧 Light sleet
    "sleetandthunder") ICON="" ;;      # ⛈ Sleet + thunder

    "snow") ICON="" ;;                 # ❄ Snow
    "heavysnow") ICON="" ;;            # 🌨 Heavy snow
    "lightsnow") ICON="" ;;            # 🌨 Light snow
    "snowandthunder") ICON="" ;;       # ⛈ Snow + thunder
    "snowshowers_day") ICON="" ;;      # 🌨 Snow showers (day)
    "snowshowers_night") ICON="" ;;    # 🌨 Snow showers (night)

    "fog") ICON="" ;;                  # 🌫 Fog

    *) ICON="" ;;                       # ❓ Unknown
esac


# Final output
printf "%s  %s°C\n" "$ICON" "$TEMP"

