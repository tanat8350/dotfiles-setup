alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias grepi='grep --ignore-case'
alias rgi='rg --ignore-case'

alias bg='setsid -f'

alias xpropc='xprop | grep WM_CLASS'

alias sp="source $HOME/.profile"

function reload() {
  source ~/.bashrc
}

function envi() {
  env | grep --ignore-case $1
}

if [[ -f '/usr/bin/snapper' ]]; then
  alias snapl='sudo snapper --config root list'
  alias snapc='sudo snapper --config root create --description'
  alias snapd='sudo snapper --config root delete'
fi

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
