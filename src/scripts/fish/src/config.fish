if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Aliases (general)
alias ls "lsd --color=always --group-directories-first"
alias ll "lsd --color=always --group-directories-first"
alias cat "bat"
alias tree "exa -T --icons"
alias grep "grep --color=auto"
alias egrep "egrep --color=auto"
alias fgrep "fgrep --color=auto" 

# For NeoVim default editor
set VISUAL '/usr/bin/nvim'
set EDITOR '/usr/bin/nvim'

# Hack The Box aliases
alias vpn-sp "sudo openvpn $(locate starting_point_Napoknot21.ovpn)" 
alias vpn-labs "sudo openvpn $(locate lab_Napoknot21.ovpn)"
alias vpn-fortress "sudo openvpn $(locate fortresses_Napoknot21.ovpn)"
alias vpn-arena "sudo openvpn $(locate release_arena_Napoknot21.ovpn)"
alias vpn-comp "sudo openvpn $(locate competitive_Napoknot21.ovpn)"

# creation of dirs
alias mktree "mkdir {nmap,content,exploits}"

# script aliases
alias extractPorts "$(locate extractPorts.sh)"
alias hostDiscovery "$(locate hostDiscovery.sh)"
alias osDiscovery "$(locate osDiscovery.sh)"
alias scanPorts "$(locate scanPorts.sh)"

#set fish_greeting

starship init fish | source
