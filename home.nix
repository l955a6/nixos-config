{ config, pkgs, ... }:
{
  imports = [
    ./features/tmux.nix
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
    xclip

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

    "niri/config.kdl".source = ./dotfiles/.config/niri/config.kdl;

    "zathura/zathurarc".source = ./dotfiles/.config/zathura/zathurarc;
  };

  programs.waybar.enable = true;

  home.file = {
    ".elan/settings.toml".text = builtins.readFile ./dotfiles/.elan/settings.toml;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  catppuccin = {
    flavor = "frappe";
  };

  programs.home-manager.enable = true;
}
