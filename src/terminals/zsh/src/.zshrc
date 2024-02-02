# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
  git
  bundler
  dotenv
  macos
  rake
  rbenv
  ruby
)

# Functions for the target machine
function settarget(){
    ip_address=$1
    machine_name=$2
    echo "$ip_address $machine_name" > $HOME/.config/bspwm/scripts/target
}

function cleartarget(){
    echo '' > $HOME/.config/bspwm/scripts/target
}


# Fix Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

#auto completition
autoload -Uz compinit
compinit
 
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


#history ignore
setopt histignorealldups sharehistory


#themes and plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export LS_COLORS="rs=0:di=34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# General Aliases

function ls() {
    lsd --color=always --group-directories-first "$@"
}

function ll() {
    lsd -lh --color=always --group-directories-first "$@"
}

function la() {
    lsd -a --color=always --group-directories-first "$@"
}

function lla() {
    lsd -lha --color=always --group-directories-first "$@"
}

function cat() {
    bat "$@"
}

function catn() {
    bat --style=plain "$@"
}

function catnp() {
    bat --style=plain --paging=never "$@"
}

function man() {
    batman "$@"
}

function mdcat() {
    mdcat "$@" | cat
}

function tree() {
    exa -T --icons "$@"
}

function grep() {
    command grep --color=auto "$@"
}

function egrep() {
    command egrep --color=auto "$@"
}

function fgrep() {
    command fgrep --color=auto "$@"
}


# NeoVim default editor
export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"


# Hack The Box
starting_point_vpn=$(locate starting_point_Napoknot21.ovpn)
lab_vpn=$(locate lab_Napoknot21.ovpn)
fortress_vpn=$(locate fortresses_Napoknot21.ovpn)
release_arena_vpn=$(locate release_arena_Napoknot21.ovpn)
competitive_vpn=$(locate competitive_Napoknot21.ovpn)

function vpn-sp() {
  sudo openvpn $starting_point_vpn
}

function vpn-labs() {
  sudo openvpn $lab_vpn
}

function vpn-fortress() {
  sudo openvpn $fortress_vpn
}

function vpn-arena() {
  sudo openvpn $release_arena_vpn
}

function vpn-comp() {
  sudo openvpn $competitive_vpn
}

function mktree() {
  mkdir -p {nmap,exploits,content}
}

# Scripts Aliases
extractPorts_script=$(locate extractPorts.sh)
hostDiscovery_script=$(locate hostDiscovery.sh)
osDiscovery_script=$(locate osDiscovery.sh)
scanPorts_script=$(locate scanPorts.sh)

function extractPorts() {
  $extractPorts_script "$@"
}

function hostDiscovery() {
  $hostDiscovery_script "$@"
}

function osDiscovery() {
  $osDiscovery_script "$@"
}

function scanPorts() {
  $scanPorts_script "$@"
}
