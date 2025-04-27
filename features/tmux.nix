{ pkgs, lib, ... }: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-option -g default-shell "${pkgs.fish}/bin/fish"

      # enable gui color
      set-option -g default-terminal "screen-256color"
      set-option -ga terminal-overrides ',xterm-256color:Tc'

      # change prefix key
      set -g prefix C-j
      unbind C-b

      # select pane with vim key bindings
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # enable vim key bindings on copy mode
      set-window-option -g mode-key vi

      # copy to clipboard like vim keybind
      bind -T copy-mode-vi v send-keys -X begin-selection

      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -sel clip > /dev/null"
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -sel clip > /dev/null"
    '';
  };
}
