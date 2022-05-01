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

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Match, Screen
from libqtile.lazy import lazy

from settings.keys import mod, keys
from settings.groups import groups

#from settings.widgets import widget_defaults, extension_defaults

layout_conf = {
    'border_focus': '#F07178',
    'border_width': 1,
    'margin': 4
}

layouts = [
    layout.Columns(
        border_focus_stack=["#d75f5f", "#8f3d3d"], 
        border_width=4
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='UbuntuMono Nerd Font',
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    foreground=["#f1ffff","#f1ffff"],
                    #foreground=["#f1ffff","#f1ffff"],
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
                widget.WindowName(
                    foreground=["#F07178","#F07178"],
                    #background=["#0f101a","#0f101a"],
                    fontsize=16,
                    font='UbuntuMono Nerd Font Bold'
                ),
                widget.CurrentLayout(
                    foreground=["#0f101a","#0f101a"],
                    background=["#F07178","#F07178"]
                ),
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
                #widget.TextBox("default config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.Sep(
                    linewidth=0,
                    padding=5,
                    #background=["#ff0000", "#ffffff"]
                ),
                widget.TextBox(
                    background=["#a151d3","#a151d3"],
                    foreground=["#000000","#000000"], #["#0f101a","#0f101a"],
                    text=" "
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
            opacity=0.90
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

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"