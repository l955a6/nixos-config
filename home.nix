{ config, pkgs, ... }:
{
  imports = [
    ./features/firefox.nix
    ./features/alacritty.nix
    ./features/fish.nix
    ./features/vscode.nix
    ./features/swaylock.nix
    ./features/swayidle.nix
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

    # Nix Lang
    nixd
    nixfmt

    # tui tools
    tig
    claude-code

    # gui tools
    zathura
    obsidian
    _1password-gui

    # software-development
    devbox

    # misc
    tree
    _1password-cli
  ];

  xsession.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "l955a6";
        email = "75358673+l955a6@users.noreply.github.com";
      };
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
}
