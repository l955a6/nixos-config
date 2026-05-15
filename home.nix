{ config, pkgs, ... }:
{
  imports = [
    ./features/firefox.nix
    ./features/alacritty.nix
    ./features/fish.nix
    ./features/vscode.nix
  ];

  home = rec {
    username = "l955a6";
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

    keyboard = {
      layout = "us";
      options = [
        "ctrl:nocaps"
        "ctrl:swap_rwin_rctl"
      ];
    };
  };

  home.packages = with pkgs; [
    # desktop
    waybar
    fuzzel
    swaylock-fancy
    swayidle

    # terminal
    tmux

    # env
    chezmoi

    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf
    fd
    killall
    wl-clipboard

    # font
    (stdenv.mkDerivation rec {
      pname = "cica";
      version = "5.0.3";
      src = fetchurl {
        url = "https://github.com/miiton/Cica/releases/download/v${version}/Cica_v${version}.zip";
        sha256 = "cbd1bcf1f3fd1ddbffe444369c76e42529add8538b25aeb75ab682d398b0506f";
      };
      nativeBuildInputs = [ unzip ];
      unpackPhase = "unzip $src";
      installPhase = "install -m644 --target $out/share/fonts/truetype/cica -D Cica-*.ttf";
    })

    # programming-languages & version management tools
    go
    elan

    # language servers & formatters

    ## Nix Lang
    nixd
    nixfmt

    ## golang
    gopls

    # tui tools
    tig

    # gui tools
    zathura
    obsidian

    # software-development
    devbox

    # misc
    tree
    hyprshot
  ];

  xsession.enable = true;

  programs.git = {
    enable = true;
    userName = "l955a6";
    userEmail = "75358673+l955a6@users.noreply.github.com";
    extraConfig = {
      core = {
        editor = "nvim";
        excludesfile = "${config.home.homeDirectory}/.config/git/ignore";
      };
    };
  };

  programs.waybar.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  catppuccin = {
    flavor = "frappe";
  };

  programs.home-manager.enable = true;

  services.swayidle =
    let
      command = "${pkgs.swaylock-fancy}/bin/swaylock-fancy";
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
