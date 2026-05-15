{ pkgs, ... }:
{
  services.swayidle =
    let
      command = "${pkgs.swaylock}/bin/swaylock -f";
    in
    {
      enable = true;
      systemdTarget = "graphical-session.target";

      extraArgs = [ "-w" ];

      timeouts = [
        {
          timeout = 300;
          command = command;
        }
      ];

      events = [
        {
          event = "before-sleep";
          command = command;
        }
        {
          event = "lock";
          command = command;
        }
      ];
    };
}
