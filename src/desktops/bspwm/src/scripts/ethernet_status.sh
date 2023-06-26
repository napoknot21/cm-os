#!/bin/sh
 
echo "%{F#2495e7}󰈀 %{F#ffffff}$(/usr/sbin/ifconfig wlp0s20f3 | grep "inet " | awk '{print $2}')%{u-}"