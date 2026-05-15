{ pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      screenshots = true;

      effect-blur = "7x5"; # radius x polarity
      effect-vignette = "0.5:0.5";

      clock = true;
      indicator = true;
      font = "Sans";
      font-size = 24;
      show-failed-attempts = true;
    };
  };

  catppuccin.swaylock.enable = true;
}
