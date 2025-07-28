# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

color_prompt=false
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color | *-kitty | alacritty) color_prompt=true ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=true
  fi
fi

# prompt
if $color_prompt; then
  # if want to show user and host, add `\u@\h`
  # PS1='${debian_chroot:+($debian_chroot)}\[\e[1;34m\][bash] \[\e[1;33m\]\t \[\e[1;36m\]\w \[\e[1;32m\]\n \[\e[0m\]'
  # \t time (HH:MM:SS)
  # \w working directory
  # \u@\h user@host
  blue='\[\e[1;34m\]'
  yellow='\[\e[1;33m\]'
  cyan='\[\e[1;36m\]'
  green='\[\e[1;32m\]'
  reset='\[\e[0m\]'
  PS1="# ${debian_chroot:+($debian_chroot)}${blue}[bash] ${yellow}\t ${cyan}\w ${reset}\n "
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# vi mode
# cannot `set -o vi` in .inputrc
set -o vi
if [[ -o vi ]]; then
  # emacs = @
  # cannot change color when empty indicator (everything goes wrong)
  # cursor also
  bind 'set show-mode-in-prompt on'
  yellow='\1\e[33m\2'
  reset='\1\e[0m\2'
  cursor_block='\1\e[2 q\2'
  cursor_normal='\1\e[6 q\2'
  bind "set vi-cmd-mode-string \"${cursor_block}${yellow}  N >${reset}\""
  bind "set vi-ins-mode-string \"${cursor_normal} \""

fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PATH=~/.console-ninja/.bin:$PATH

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

# conda (miniconda aur)
conda_path='/opt/miniconda3/etc/profile.d/conda.sh'
[[ -f "$conda_path" ]] && source "$conda_path"

function eval-if-exists() {
  if [[ -f "/usr/bin/$1" ]]; then
    # eval "$($1 $2)"
    eval "$($@)"
  fi
}

# eval-if-exists fzf '--bash'
# eval-if-exists zoxide 'init bash'
eval-if-exists fzf --bash
eval-if-exists zoxide init bash
eval-if-exists atuin init bash
# required by atuin
[[ -f '/usr/bin/atuin' && -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

function source-if-exists() {
  [[ -f "$1" ]] && source "$1"
}

source-if-exists "$HOME/.local/share/blesh/ble.sh"
[[ -f /opt/miniconda3/etc/profile.d/conda.sh ]] && source /opt/miniconda3/etc/profile.d/conda.sh

function source_in_folder {
  # quoted path will not work
  for file in $1/*.sh; do
    [ -r "$file" ] && source "$file"
  done
}
source_in_folder "$HOME/.config/bash"
banner_bash
