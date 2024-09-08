#/bin/python3

from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn("/usr/bin/alacritty"), desc="Launch terminal"),
    
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Custom shortcuts

    # ------------ Programs Configs ------------

    # Brave (browser)
    Key([mod], "b", lazy.spawn("/usr/bin/brave"), desc="Open a new window of the browser"),
    Key([mod, "shift"], "b", lazy.spawn("/usr/bin/brave --incognito"), desc="Open a new private window of the browser"),

    # Rofi (menu)
    Key([mod], "m", lazy.spawn("/usr/bin/rofi -show drun -config ~/.config/rofi/config_qtile.rasi"), desc="open the rofi menu"), #we exec drun in order to show icons
    Key([mod, "shift"], "m", lazy.spawn("/usr/bin/rofi -show window -config ~/.config/rofi/config_qtile.rasi"), desc="list all the active windows"),
    
    # Scrot (screenshot)
    Key([mod], "s", lazy.spawn("/usr/bin/scrot -e 'mv $f ~/Images/Screenshots/'"), desc="take a screenshot of the (all) window(s)"),
    
    # Redshitf (temperature)
    Key([mod], "x", lazy.spawn("/usr/bin/redshift -O 2400"), desc="turns temperature to 2400 for hurt less the eyes"),
    Key([mod, "shift"], "x", lazy.spawn("/usr/bin/redshift -x"), desc="reset device temperature"),

    # Visual Studio Code (code editor)
    Key([mod], "v", lazy.spawn("/usr/bin/code"), desc="open vs code window"),

    # Tor (anonymous browser)
    Key([mod, "Shift"], "t", lazy.spawn("/usr/bin/torbrowser-launcher"), desc="open a tor browser window"),
    
    # ------------ Hardware Configs ------------

    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="turn down the volume of 5%"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="turn up the volume of 5%"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="mute all volume"),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%"), desc="turn on the brightness of 10%"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-"), desc="turn off th brightness of 10%"),

    #Keboard layout
    Key([mod, "shift"], "f", lazy.spawn("/usr/bin/setxkbmap fr"), desc="change keyboard layout to french - fr"),
    Key([mod, "shift"], "u", lazy.spawn("/usr/bin/setxkbmap us"), desc="change keyboard layout to english - us"),
    Key([mod, "shift"], "e", lazy.spawn("/usr/bin/setxkbmap es"), desc="change keyboard layout to spanish - es"),
    Key([mod, "shift"], "d", lazy.spawn("/usr/bin/setxkbmap de"), desc="change keyboard layout to german - de"),
    Key([mod, "shift"], "n", lazy.spawn("/usr/bin/setxkbmap nl"), desc="change keyboard layout to dutch - nl"),

    #Screen locker
    Key([mod], "c", lazy.spawn("/usr/bin/slock"), desc="Lock the minimalist locker session the current session"),
    Key([mod, "shift"], "c", lazy.spawn("/usr/bin/i3lock-fancy"), desc="Lock with the i3lock locker")
]