#!/usr/bin/env bash

# Define color and style variables
RESET_STYLE="#[fg=brightwhite,bg=#15161e,nobold,noitalics,nounderscore,nodim]"
BG="#1A1B26"
LEFT_FG="#15161e"
LEFT_BG="#6EA3FE"
CURRENT_FG="#44dfaf"
CURRENT_BG="#2B324B"
DEFAULT_FG="#606490"
DEFAULT_BG="default"
DEFAULT_STYLE="#[fg=${DEFAULT_FG},bg=${DEFAULT_BG},none,dim]"
RIGHT_FG="#a9b1d6"
RIGHT_BG="#24283B"

# Other configuration
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_PATH="$CURRENT_DIR/src"
PANE_BASE="$(tmux show -g | grep pane-base-index | cut -d" " -f2 | bc)"

# Scripts
cmus_status="#($SCRIPTS_PATH/cmus-tmux-statusbar.sh)"
git_status="#($SCRIPTS_PATH/git-status.sh #{pane_current_path})"
wb_git_status="#($SCRIPTS_PATH/wb-git-status.sh #{pane_current_path} &)"
custom_pane="#($SCRIPTS_PATH/custom-number.sh #P -o)"
zoom_number="#($SCRIPTS_PATH/custom-number.sh #P -O)"

# Function to add separator
add_separator() {
  local from_bg=$1
  local to_bg=$2
  echo "#[fg=${from_bg},bg=${to_bg}]"
}

# Function to add separator
add_separator_r() {
  local from_bg=$1
  local to_bg=$2
  echo "#[fg=${from_bg},bg=${to_bg}]"
}

# Tmux configuration
tmux set -g status-style bg=$BG
tmux set -g status-right-length 150

# Status Left
tmux set -g status-left "#{?client_prefix,#[fg=$CURRENT_FG]󰠠 ,#[fg=$DEFAULT_FG]󰤂 }"

# Window Status - Unfocus
unfocus_separator=$(add_separator $BG $DEFAULT_BG)
unfocus_format="#[fg=${DEFAULT_FG},bg=${DEFAULT_BG},dim]  #W"
tmux set -g window-status-format "${unfocus_separator}${unfocus_format} "

# Window Status - Focus
focus_separator_start=$(add_separator $BG $CURRENT_BG)
focus_format="#[fg=${CURRENT_FG},bg=${CURRENT_BG},bold]  #W"
focus_separator_end=$(add_separator $CURRENT_BG $DEFAULT_BG)
tmux set -g window-status-current-format "${focus_separator_start}${focus_format} ${focus_separator_end}"

#+--- Bars RIGHT ---+
right_separator=$(add_separator_r $RIGHT_BG $BG)
tmux set -g status-right "$cmus_status${right_separator}#[fg=$RIGHT_FG,bg=$RIGHT_BG] %m/%d $git_status$wb_git_status"
tmux set -g window-status-separator ""
