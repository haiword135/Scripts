#!/bin/sh

case $BUTTON in
	1) notify-send "🧠 Memory hogs" "$(ps axch -o cmd:15,%mem --sort=-%mem | head)" ;;
	2) st -t statusutil_mem -g 82x25+$((mx - 328))+$((my + 20)) -c float -e btop ;;
	3) notify-send "🧠 内存模块" "\- 查看内存使用率和总量.
- 左键点击查看内存占用情况.
- 中键点击打开htop." ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

free --mebi | sed -n '2{p;q}' | awk '{printf ("🧠:%2.2fGB/%2.2fGB\n", ($3 / 1024), ($2 / 1024))}'