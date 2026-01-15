#!/bin/python3

from libqtile import layout
from libqtile.config import Match
#from .theme import colors

layout_conf = {
    'border_focus': '#F07178',
    'border_width': 1,
    'margin': 4
}

layouts = [
    layout.Max(),
    layout.Columns(
        border_focus_stack=["#d75f5f", "#8f3d3d"], 
        border_width=4
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    layout.Bsp(**layout_conf),
    layout.Matrix(
        columns=2,
        **layout_conf
    ),
    # layout.MonadTall(),
    layout.MonadWide(**layout_conf),
    layout.RatioTile(**layout_conf),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]