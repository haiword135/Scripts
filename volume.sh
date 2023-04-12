#!/bin/sh

# Prints the current volume or 🔇 if muted.

case $BUTTON in
	1) st -e alsamixer ;;
	2) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
	# 4) wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ ;;
	# 5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- ;;
	3) notify-send "📢 音量模块" "\- 音量调节:🔇,🔈,🔉,🔊
- 左键点击打开pulsemixer
- 中键点击静音.
- 滑轮上下调整音量." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

# If muted, print 🔇 and exit.
[ "$vol" != "${vol%\[MUTED\]}" ] && echo 🔇 && exit

vol="${vol#Volume: }"

split() {
	# For ommiting the . without calling and external program.
	IFS=$2
	set -- $1
	printf '%s' "$@"
}

vol="$(printf "%.0f" "$(split "$vol" ".")")"

case 1 in
	$((vol >= 70)) ) icon="🔊" ;;
	$((vol >= 30)) ) icon="🔉" ;;
	$((vol >= 1)) ) icon="🔈" ;;
	* ) echo 🔇 && exit ;;
esac

echo "$icon$vol%"