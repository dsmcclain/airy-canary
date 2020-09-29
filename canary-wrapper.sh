!#/bin/bash
filepath="$( cd "$( dirname "$0" )" && pwd )/canary.rb"
sensor_id=$1
output=$(ruby $filepath $sensor_id)
if [ -n "$output" ]
then
  zenity --warning --title="Air Quality Warning" --text="$output" --width=600 --display=:0.0 2>/dev/null
fi