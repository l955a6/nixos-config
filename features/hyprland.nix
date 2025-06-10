{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      input = { kb_options = "ctrl:nocaps,ctrl:swap_rwin_rctl"; };
      "$mainMod" = "SUPER";
      "$shift" = "SHIFT";
      "$alt" = "ALT";

      exec-once = [ "fcitx5 -D" ];

      bindd = [
        # Shortcuts
        "$mainMod, q, Kill the focused application, killactive"

        # Applications
        "$mainMod, return, Open Alacritty, exec, alacritty"
        "$mainMod, d, 	   Open Rofi,      exec, rofi -show drun"

        # Move focus with $mainMod + hjkl
        "$mainMod, h, Move focus left,  movefocus, l"
        "$mainMod, j, Move focus down,  movefocus, d"
        "$mainMod, k, Move focus up,    movefocus, u"
        "$mainMod, l, move focus right, movefocus, r"

        # Move window with mainMod + shift + hjkl
        "$mainMod $shift, h, Move window left,  movewindow, l"
        "$mainMod $shift, j, Move window down,  movewindow, d"
        "$mainMod $shift, k, Move window up,    movewindow, u"
        "$mainMod $shift, l, Move window right, movewindow, r"

        # screen shot
        "$mainMod $alt, 3, Take a full-screen screenshot,  exec, hyprshot -m output ~/Pictures -f hyprshot_$(date +%s).png -c"
        "$mainMod $alt, 4, Take a screenshot of selection, exec, hyprshot -m region ~/Pictures -f hyprshot_$(date +%s).png -c"
      ] ++ (builtins.concatLists (builtins.genList (i:
        let workSpace = i + 1;
        in [
          "$mainMod, code:1${toString i}, Go to workspace ${
            toString workSpace
          }, workspace, ${toString workSpace}"
          "$mainMod $shift, code:1${toString i}, Move window to ${
            toString workSpace
          }, movetoworkspacesilent, ${toString workSpace}"
        ]) 9));

      decoration = {
        active_opacity = 0.8;
        inactive_opacity = 0.5;
      };
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
}
