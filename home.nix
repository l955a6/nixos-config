{ config, pkgs, firefox-addons, ... } : {
  imports = [
    ./features/firefox.nix
    ./features/alacritty.nix
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
