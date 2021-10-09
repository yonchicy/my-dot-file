#!/bin/sh

xmodmap -e "clear lock"
xmodmap -e "clear control"
xmodmap -e "add control = Caps_Lock Control_L Control_R"
xmodmap -e "keycode 66 = Control_L Caps_Lock NoSymbol NoSymbol"
