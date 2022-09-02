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

#set fish_greeting

starship init fish | source
