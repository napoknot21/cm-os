#!/bin/python3

from libqtile import widget
#from .theme import colors

def base () {
    return {
        'foreground': ,
        'background': 
    }
}

def separator () {
    return widget.Sep(**base(), linewidth=0, padding=5)
}


def workspaces () :
    return [
        separator()
    ]


widget_defaults = dict(
    font="UbuntuMono Nerd Font Sold",
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()