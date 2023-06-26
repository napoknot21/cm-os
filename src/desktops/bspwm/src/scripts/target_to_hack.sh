#!/bin/bash
 
ip_address=$(/usr/bin/cat $HOME/.config/bspwm/scripts/target | awk '{print $1}')
machine_name=$(/usr/bin/cat $HOME/.config/bspwm/scripts/target | awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#e51d0b}󰯐 %{F#ffffff}$ip_address%{u-} - $machine_name"
else
    echo "%{F#e51d0b}󰯐 %{u-}%{F#ffffff} No target"
fi