{ config, pkgs, ... } : {
  home = rec {
    username = "pkino";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
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
