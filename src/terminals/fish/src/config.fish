if status is-interactive
    # Commands to run in interactive sessions can go here
end


# Aliases (general)
function ls
    command lsd --color=always --group-directories-first $argv
end

function ll
    command lsd -lh --color=always --group-directories-first $argv
end

function la 
    command lsd -a --color=always --group-directories-first $argv
end

function lla
    command lsd -lha --color=always --group-directories-first $argv
end

function cat
    command bat $argv
end

function catn
    command bat --style=plain $argv
end

function catnp
    command bat --style=plain --paging=never $argv
end

function man
    command batman $argv
end

function mdcat
    command mdcat $argv | cat
end

function tree
    command exa -T --icons $argv
end

function grep
    command grep --color=auto $argv
end

function egrep
    command egrep --color=auto $argv
end

function fgrep
    command fgrep --color=auto $argv
end


# NeoVim default editor
set VISUAL "/usr/bin/nvim"
set EDITOR "/usr/bin/nvim"


# Hack The Box
set starting_point_vpn (locate starting_point_Napoknot21.ovpn)
set lab_vpn (locate lab_Napoknot21.ovpn)
set fortress_vpn (locate fortresses_Napoknot21.ovpn)
set release_arena_vpn (locate release_arena_Napoknot21.ovpn)
set competitive_vpn (locate competitive_Napoknot21.ovpn)

function vpn-sp
    command sudo openvpn $starting_point_vpn
end

function vpn-labs
    command sudo openvpn $lab_vpn
end

function vpn-fortress
    command sudo openvpn $fortress_vpn
end

function vpn-arena
    command sudo openvpn $release_arena_vpn
end

function vpn-compcommand
    command sudo openvpn $competitive_vpn
end

function mktree
    command mkdir {nmap,content,exploits}
end


# Scripts Aliases
set extractPorts_script (locate extractPorts.sh)
set hostDiscovery_script (locate hostDiscovery.sh)
set osDiscovery_script (locate osDiscovery.sh)
set scanPorts_script (locate scanPorts.sh)

function extractPorts
    command $extractPorts_script $argv
end

function hostDiscovery
    command $hostDiscovery_script $argv
end

function osDiscovery
    command $osDiscovery_script $argv
end

function scanPorts
    command $scanPorts_script $argv
end


#starShip
starship init fish | source

# opam configuration
source /home/napoknot21/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
