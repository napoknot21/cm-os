if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Aliases (general)
alias ls "lsd --color=always --group-directories-first"
alias ll "lsd --color=always --group-directories-first"
alias cat "bat"
alias man "batman"
alias tree "exa -T --icons"
alias grep "grep --color=auto"
alias egrep "egrep --color=auto"
alias fgrep "fgrep --color=auto" 

# For NeoVim default editor
set VISUAL '/usr/bin/nvim'
set EDITOR '/usr/bin/nvim'

# Hack The Box aliases
set starting_point_vpn (locate starting_point_Napoknot21.ovpn)
set lab_vpn (locate lab_Napoknot21.ovpn)
set fortress_vpn (locate fortresses_Napoknot21.ovpn)
set release_arena_vpn (locate release_arena_Napoknot21.ovpn)
set competitive_vpn (locate competitive_Napoknot21.ovpn)

alias vpn-sp "sudo openvpn $starting_point_vpn"
alias vpn-labs "sudo openvpn $lab_vpn"
alias vpn-fortress "sudo openvpn $fortress_vpn"
alias vpn-arena "sudo openvpn $release_arena_vpn"
alias vpn-comp "sudo openvpn $competitive_vpn"

# creation of dirs
alias mktree "mkdir {nmap,content,exploits}"

# script aliases
set extractPorts_script (locate extractPorts.sh)
set hostDiscovery_script (locate hostDiscovery.sh)
set osDiscovery_script (locate osDiscovery.sh)
set scanPorts_script (locate scanPorts.sh)

alias extractPorts $extractPorts_script
alias hostDiscovery $hostDiscovery_script
alias osDiscovery $osDiscovery_script
alias scanPorts $scanPorts_script

#set fish_greeting

starship init fish | source

# opam configuration
source /home/napoknot21/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
