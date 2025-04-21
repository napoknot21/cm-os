# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from settings.keys import mod, keys

import os
import subprocess

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])


# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i)for i in [" 󰙯  ", "   ", "   ", "   ", "   ", " 󰏆  ", "   ", "   ", "   "]]

for i, group in enumerate(groups) :
    actual_key = str(i+1)
    keys.extend(
        [
            # mod + group number = switch to group*
            Key(
                [mod],
                actual_key,
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(actual_key),
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                actual_key,
                lazy.window.togroup(group.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(actual_key),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

# Drag floating layouts.
layout_conf = {
    'border_focus': '#F07178',
    'border_width': 2,
    'margin': 4,
    'insert_position': 1
}

layouts = [
    layout.Columns(
        # border_focus_stack=["#d75f5f", "#8f3d3d"], 
        border_width=2,
        margin=2,
    ),
    layout.Max(
        margin=2
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    layout.Tile(
        border_width=2,
        margin=2,
        border_on_single=False
    ),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="UbuntuMono Nerd Font",
    fontsize=17,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # Group box
                widget.GroupBox(
                    foreground=["#f1ffff","#f1ffff"],
                    # background=["#0f101a","#0f101a"],
                    font='UbuntuMono Nerd Font',
                    fontsize=16,
                    margin_y=3,
                    margin_x=0,
                    padding_y=8,
                    padding_x=5,
                    borderwidth=1,
                    active=["#f1ffff","#f1ffff"], #light
                    inactive=["#f1ffff","#f1ffff"], # inactive orginal color "#4c566a" (light now)
                    rounded=True,
                    highlight_method='block',
                    urgent_alert_method='block',
                    urgent_border=["#F07178","#F07178"], # urgent
                    this_current_screen_border=["#F07178","#F07178"],
                    this_screen_border=["#5c5c5c","#5c5c5c"], #grey original oolor "#353c4a" (other now)
                    other_current_screen_border=["#0f101a","#0f101a"], # dark
                    other_screen_border=["#0f101a","#0f101a"], #dark
                    disable_drag=True
                ),
                
                # Window name
                widget.WindowName(
                    foreground=["#F07178","#F07178"],
                    #background=["#0f101a","#0f101a"],
                    fontsize=16,
                    font='UbuntuMono Nerd Font Bold'
                ),
                
                widget.TextBox(
                    foreground=["#F07178","#F07178"],
                    text="", # !  Icon: nf-oct-triangle_left
                    fontsize=40,
                    padding=0
                ),
                widget.CurrentLayoutIcon(
                    foreground=["#0f101a","#0f101a"],
                    background=["#F07178","#F07178"],
                    scale=0.65
                ),
                widget.CurrentLayout(
                    foreground=["#0f101a","#0f101a"],
                    background=["#F07178","#F07178"]
                ),

                # Layout
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),

                widget.Sep(
                    linewidth=0,
                    padding=5,
                    background=["#F07178","#F07178"]
                ),

                widget.Sep(
                    linewidth=0,
                    padding=5,
                    background=["#F07178","#F07178"]
                ),

                #Systrays
                widget.TextBox(
                    foreground=["#0f101a","#0f101a"],
                    background=["#F07178","#F07178"],
                    text="", # !  Icon: nf-oct-triangle_left
                    fontsize=38,
                    padding=0
                ),
                widget.Systray(
                    background=["#0f101a","#0f101a"]
                ),
                widget.Sep(
                    linewidth=0,
                    padding=5,
                    background=["#0f101a","#0f101a"]
                ),
                
                # Clock 
                widget.TextBox(
                    foreground=["#a151d3","#a151d3"],
                    background=["#0f101a","#0f101a"],
                    text="", # !  Icon: nf-oct-triangle_left
                    fontsize=38,
                    padding=0
                ),
                widget.TextBox(
                    background=["#a151d3","#a151d3"],
                    foreground=["#000000","#000000"], #["#0f101a","#0f101a"],
                    text="󰔠 "
                ),
                widget.Clock(
                    background=["#a151d3","#a151d3"],
                    foreground=["#000000","#000000"],
                    padding=5,
                    format='%d/%m/%Y - %H:%M '
                    #format="%Y-%m-%d %a %I:%M %p"
                ),
            ],
            24,
            opacity=0.80
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),

    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    foreground=["#f1ffff","#f1ffff"],
                    #background=["#0f101a","#0f101a"],
                    font='UbuntuMono Nerd Font',
                    fontsize=16,
                    margin_y=3,
                    margin_x=0,
                    padding_y=8,
                    padding_x=5,
                    borderwidth=1,
                    active=["#f1ffff","#f1ffff"], #light
                    inactive=["#f1ffff","#f1ffff"], # inactive orginal color "#4c566a" (light now)
                    rounded=True,
                    highlight_method='block',
                    urgent_alert_method='block',
                    urgent_border=["#F07178","#F07178"], # urgent
                    this_current_screen_border=["#F07178","#F07178"], #focus original color "#a151d3" (urgent now)
                    this_screen_border=["#5c5c5c","#5c5c5c"], #grey original oolor "#353c4a" (other now)
                    other_current_screen_border=["#0f101a","#0f101a"], # dark
                    other_screen_border=["#0f101a","#0f101a"], #dark
                    disable_drag=True
                ),
                #widget.Prompt(),
                
                # Window name
                widget.WindowName(
                    foreground=["#F07178","#F07178"],
                    #background=["#0f101a","#0f101a"],
                    fontsize=16,
                    font='UbuntuMono Nerd Font Bold'
                ),
                
                widget.TextBox(
                    foreground=["#F07178","#F07178"],
                    text="", # !  Icon: nf-oct-triangle_left
                    fontsize=40,
                    padding=0
                ),
                widget.CurrentLayoutIcon(
                    foreground=["#0f101a","#0f101a"],
                    background=["#F07178","#F07178"],
                    scale=0.65
                ),
                widget.CurrentLayout(
                    foreground=["#0f101a","#0f101a"],
                    background=["#F07178","#F07178"]
                ),
                
                
                # Layout
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),

                widget.Sep(
                    linewidth=0,
                    padding=5,
                    background=["#F07178","#F07178"]
                ),

                widget.Sep(
                    linewidth=0,
                    padding=5,
                    background=["#F07178","#F07178"]
                ),
                
                #widget.TextBox("default config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                
                # Clock 
                widget.TextBox(
                    foreground=["#a151d3","#a151d3"],
                    background=["#F07178","#F07178"],
                    text="", # !  Icon: nf-oct-triangle_left
                    fontsize=38,
                    padding=0
                ),
                widget.TextBox(
                    background=["#a151d3","#a151d3"],
                    foreground=["#000000","#000000"], #["#0f101a","#0f101a"],
                    text="󰔠 "
                ),
                widget.Clock(
                    background=["#a151d3","#a151d3"],
                    foreground=["#000000","#000000"],
                    padding=5,
                    format='%d/%m/%Y - %H:%M '
                    #format="%Y-%m-%d %a %I:%M %p"
                ),
                #widget.QuickExit(),
            ],
            24,
            opacity=0.80
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
