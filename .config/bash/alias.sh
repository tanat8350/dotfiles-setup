alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function reload() {
  source ~/.bashrc
}

alias grepi='grep --ignore-case'
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
