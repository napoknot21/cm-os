from libqtile import widget
#from .theme import colors

def base (fg='#f1ffff', bg='#0f101a') :
    # with 
    # -> #f1ffff => light
    # -> #0f101a => dark
    return {
        'foreground': [fg,fg],
        'background': [bg,bg] 
    }



def separator () :
    return widget.Sep(**base(), linewidth=0, padding=5)



def icon (fg='#000000', bg='#0f101a', fontsize=16, text="?") :
    # with 
    # -> #000000 => text
    # -> #0f101a => dark
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def powerline (fg="#f1ffff", bg="#0f101a") :
    # with 
    # -> #f1ffff => light
    # -> #0f101a => dark
    return widget.TextBox(
        **base(fg, bg),
        text="", # !  Icon: nf-oct-triangle_left
        fontsize=37,
        padding=-2
    )


def workspaces () :
    return [
        separator(),
        widget.GroupBox(
            **base(fg='#f1ffff'), #foreground=["#f1ffff","#f1ffff"],
            font='UbuntuMono Nerd Font',
            fontsize=19,
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
        separator(),
        widget.WindowName(
            # *base(fg='#F07178'), # color focus
            foreground=["#f1ffff","#f1ffff"],
            #background=["#0f101a","#0f101a"],
            fontsize=16,
            padding=5, #Why not 3 ?
            font='UbuntuMono Nerd Font Bold'
        ),
        separator(),
    ]


# color1 = ['#a151d3']
# color2 = ['#F07178']
# color3 = ['#fb9f7f']
# color4 = ['#ffd47e']


primary_widgets = [
    *workspaces(),

    separator(),

    powerline(fg='#F07178'), #color

    widget.CurrentLayoutIcon(
        **base("#F07178", "#0f101a"),
        #foreground=["#0f101a","#0f101a"],
        #background=["#F07178","#F07178"],
        scale=0.65
    ),

    widget.CurrentLayout(
        foreground=["#0f101a","#0f101a"],
        background=["#F07178","#F07178"]
    ),

    icon(text=' ')

    widget.CheckUpdates(

    )

    powerline() # color



     

    widget.Clock(
        background=["#a151d3","#a151d3"],
        foreground=["#000000","#000000"],
        padding=5,
        format='%d/%m/%Y - %H:%M '
        #format="%Y-%m-%d %a %I:%M %p"
    ),

]




widget_defaults = {
    'font'='UbuntuMono Nerd Font Sold',
    'fontsize'=17,
    'padding'=3,
}
extension_defaults = widget_defaults.copy()



