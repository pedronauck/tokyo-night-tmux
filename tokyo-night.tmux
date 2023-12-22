#!/usr/bin/env bash
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# title      Tokyo Night                                              +
# version    1.0.0                                                    +
# repository https://github.com/logico-dev/tokyo-night-tmux           +
# author     Lógico                                                   +
# email      hi@logico.com.ar                                         +
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

RESET="#[fg=brightwhite,bg=#15161e,nobold,noitalics,nounderscore,nodim]"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tmux set -g status-style bg=#1A1B26
tmux set -g status-right-length 150

SCRIPTS_PATH="$CURRENT_DIR/src"
PANE_BASE="$(tmux show -g | grep pane-base-index | cut -d" " -f2 | bc)"

cmus_status="#($SCRIPTS_PATH/cmus-tmux-statusbar.sh)"
git_status="#($SCRIPTS_PATH/git-status.sh #{pane_current_path})"
wb_git_status="#($SCRIPTS_PATH/wb-git-status.sh #{pane_current_path} &)"
custom_pane="#($SCRIPTS_PATH/custom-number.sh #P -o)"
zoom_number="#($SCRIPTS_PATH/custom-number.sh #P -O)"

#+--- Bars LEFT ---+
# Session name
tmux set -g status-left "#[fg=#15161e,bg=#2b97fa,bold] #{?client_prefix,󰠠 ,#[dim]󰤂 }#[nodim]#S $RESET"

#+--- Windows ---+
# Focus
tmux set -g window-status-current-format "#[fg=#44dfaf,bg=#1F2335]   #[fg=#a9b1d6,bg=#1F2335]$custom_number #[bold,nodim]#W#[nobold,dim]# "
# Unfocused
tmux set -g window-status-format "#[fg=#c0caf5,bg=default,none,dim]   $custom_number #W#[nobold,dim]# "

#+--- Bars RIGHT ---+
tmux set -g status-right "$cmus_status#[fg=#a9b1d6,bg=#24283B]  %Y-%m-%d #[]❬ %H:%M $git_status$wb_git_status"
tmux set -g window-status-separator ""
