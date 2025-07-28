
# welcome banner
function banner() {
  blue='\033[0;34m'
  yellow='\033[0;33m'
  reset='\033[0m'
  main_color=$1
  echo -e "
    ${main_color}$2 ${yellow}v$3
    ${reset}Uptime: ${main_color}$(uptime -p | sed 's/up //')${reset}
    "
}
function ansi_color() {
  case $1 in
    blue) echo -e "\033[0;34m" ;;
    yellow) echo -e "\033[0;33m" ;;
    reset) echo -e "\033[0m" ;;
    orange) echo -e "\033[0;38;5;208m" ;; # orange
    *) echo -e "\033[0m" ;; # default to reset
  esac
}
function banner_bash() {
  banner $(ansi_color blue) bash ${BASH_VERSION%\(*}
}

function banner_zsh() {
  banner $(ansi_color orange) zsh ${ZSH_VERSION%\(*}
}
