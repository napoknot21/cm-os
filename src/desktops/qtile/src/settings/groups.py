#!/bin/python3

from libqtile.config import Key, Group
from libqtile.command import lazy
from .keys import mod, keys

#icons from https://www.nerdfonts.com/cheat-sheet

groups = [Group(i)for i in [" 󰙯  ", "   ", "   ", "   ", "   ", " 󰏆  ", "   ", "   ", "   "]]

for i, group in enumerate(groups) :
    actual_key = str(i+1)
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key([mod], actual_key, lazy.group[group.name].toscreen(), desc="Switch to group {}".format(actual_key)),

            # mod1 + shift + letter of group = switch to & move focused window to group
            Key([mod, "shift"], actual_key, lazy.window.togroup(group.name, switch_group=True), desc="Switch to & move focused window to group {}".format(actual_key))
            
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name), desc="move focused window to group {}".format(i.name)),
        ]
    )
