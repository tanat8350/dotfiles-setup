function logout {
  [[ ! -z $(pgrep awesome) ]] && return $(awesome-client 'awesome.quit()')
  [[ ! -z $(systemctl status sddm | grep --regexp 'Active: .* \(running\)') ]] && return $(systemctl restart sddm)
  return $(loginctl terminate-session "$XDG_SESSION_ID")
}

alias lock='bash ~/dotfiles/stow-ignore/scripts/i3lock-color-lock'
