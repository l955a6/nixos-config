{ config, pkgs, firefox-addons, ... } : {
  imports = [
    ./features/firefox.nix
  ];

  home = rec {
    username = "pkino";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";

    keyboard = {
      layout = "us";
      options = [
        "ctrl:nocaps"
	"ctrl:swap_rwin_rctl"
      ];
    };
  };

  home.packages = with pkgs; [
    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf
    fd

    # misc
    tree
  ];

  xsession.enable = true;

  programs.git = {
    enable = true;
    userName = "pkino";
    userEmail = "pkino@pkino.net";
    extraConfig = {
      core.editor = "nvim";
    };
  };

  programs.home-manager.enable = true;
}
