#!/bin/bash

# if tpm directory does not exist then clone it
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

cat << EOT > ~/.tmux.conf
# Reference: https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/

#--------------------
# Key Bindings
#--------------------

# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# reload config file (change file location to your the tmux.conf you want to use)
bind r source-file ~/.tmux.conf

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
bind-key -n Home send Escape "OH"
bind-key -n End send Escape "OF"

#--------------------
# Options
#--------------------

# Enable mouse mode (tmux 2.1 and above)
set -g mouse on

# don't rename windows automatically
set-option -g allow-rename off

# retain color in bash, etc.
set -g default-shell /bin/zsh
set -g default-terminal "screen-256color"

# use vi keys in buffer
setw -g mode-keys vi


#--------------------
# Plugins
#--------------------
set -g @plugin 'jimeh/tmux-themepack'


#--------------------
# Themes
#--------------------
set -g @themepack 'powerline/default/gray'



#--------------------
# Initialize TPM
#--------------------
# TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOT

tmux source-file ~/.tmux.conf
