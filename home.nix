{ config, pkgs, firefox-addons, catppuccin, nix-vscode-extensions, ... }: {
  imports = [
    ./features/hyprland.nix
    ./features/tmux.nix
    ./features/firefox.nix
    ./features/alacritty.nix
    ./features/fish.nix
    ./features/vscode.nix
  ];

  home = rec {
    username = "pkino";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    keyboard = {
      layout = "us";
      options = [ "ctrl:nocaps" "ctrl:swap_rwin_rctl" ];
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
    killall

    # font
    (stdenv.mkDerivation rec {
      pname = "cica";
      version = "5.0.3";
      src = fetchurl {
        url =
          "https://github.com/miiton/Cica/releases/download/v${version}/Cica_v${version}.zip";
        sha256 =
          "cbd1bcf1f3fd1ddbffe444369c76e42529add8538b25aeb75ab682d398b0506f";
      };
      nativeBuildInputs = [ unzip ];
      unpackPhase = "unzip $src";
      installPhase =
        "install -m644 --target $out/share/fonts/truetype/cica -D Cica-*.ttf";
    })

    # language servers & formatters
    ## Nix Lang
    nixd
    nixfmt

    # tui tools
    tig

    # gui tools
    zathura

    # misc
    tree
    hyprshot
  ];

  xsession.enable = true;

  programs.git = {
    enable = true;
    userName = "pkino";
    userEmail = "pkino@pkino.net";
    extraConfig = {
      core = {
        editor = "nvim";
        excludesfile = "${config.home.homeDirectory}/.config/git/ignore";
      };
    };
  };

  xdg.configFile = {
    "git/ignore".text = ''
      .envrc
    '';

    "tig/config".text = ''
      set refresh-mode = auto

      # move page-up/down like vim
      bind generic <C-f> move-page-down
      bind generic <C-b> move-page-up
      bind generic g     none
      bind generic gg    move-first-line
      bind main    G     move-last-line
      bind generic G     move-last-line

      # execute rebase
      bind main    <C-r> !git rebase -i %(commit)
      bind generic <C-r> !git rebase -i %(commit) 

      # tmp commit
      bind status  T     !git commit -m 'tmp'
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  catppuccin = {
    flavor = "frappe";
    enable = true;
  };

  programs.home-manager.enable = true;
}
