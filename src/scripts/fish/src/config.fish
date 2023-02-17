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
alias vpn-sp "sudo openvpn /home/napoknot21/Desktop/hacking/HTB/vpn/starting_point_Napoknot21.ovpn" 
alias vpn-labs "sudo openvpn /home/napoknot21/Desktop/hacking/HTB/vpn/lab_Napoknot21.ovpn"
alias vpn-fortress "sudo openvpn /home/napoknot21/Desktop/hacking/HTB/vpn/fortresses_Napoknot21.ovpn"
alias vpn-arena "sudo openvpn /home/napoknot21/Desktop/hacking/HTB/vpn/release_arena_Napoknot21.ovpn"

# Creation of work dirs
alias mktree "mkdir {nmap,content,exploits}"

# script aliases
alias extractPorts "/home/napoknot21/Desktop/hacking/utils-tools/extractPorts.sh"
alias hostDiscovery "/home/napoknot21/Desktop/hacking/utils-tools/hostDiscovery.sh"
alias osDiscovery "/home/napoknot21/Desktop/hacking/utils-tools/osDiscovery.sh"
alias scanPorts "/home/napoknot21/Desktop/hacking/utils-tools/scanPorts.sh"

#set fish_greeting

starship init fish | source
