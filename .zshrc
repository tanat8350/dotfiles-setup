# SECTION: History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# SECTION: Prompt and vim mode
autoload -U colors && colors
bindkey -v
# other name will not work
function zle-keymap-select {
  cursor_block='\e[2 q'
  cursor_normal='\e[6 q'
  if [[ $KEYMAP == vicmd ]]; then
    MODE="N > "
    echo -ne $cursor_block
  else
    MODE=""
    echo -ne $cursor_normal
  fi
  zle reset-prompt
}
zle -N zle-keymap-select
orange=16
PROMPT=$'# %F{$orange}[zsh] %F{yellow}%* %F{cyan}%~\n  %F{yellow}$MODE%f'
setopt PROMPT_SUBST

# SECTION: Tab completion
autoload -U compinit
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)


# ignore error messages
# https://superuser.com/questions/1607629/how-to-suppress-error-messages-in-zsh
exec 7>&2           # "save" stderr
exec 2>/dev/null    # redirect

exec 2>&7           # restore
exec 7>&-

PATH=~/.console-ninja/.bin:$PATH

[[ -f '/usr/bin/atuin' ]] && eval "$(atuin init zsh)"

function source_if_exists {
  [[ -f "$1" ]] && source "$1"
}

# ubuntu
source_if_exists /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# arch
source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function source_in_folder {
  # quoted path will not work
  for file in $1/*.sh; do
    [ -r "$file" ] && source "$file"
  done
}

dot_config_dir="$HOME/.config"
source_in_folder "$dot_config_dir/bash"
source_in_folder "$dot_config_dir/zsh"
banner_zsh


