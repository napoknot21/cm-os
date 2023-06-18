#!/usr/bin/sh

# Script for generating and get all python packages installed on your system.
# This could be useful for re install (or not) some missing packages

ls /usr/share/licenses/python* | grep "python" | awk -F "/" '{print $5}' | awk -F ":" '{print $1}' > ./../python_pcks

# Export all packages names in a file
#
# @author Napoknot21
