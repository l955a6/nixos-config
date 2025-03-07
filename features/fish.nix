{ lib, pkgs, config, catppuccin, ... }: {
  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      {
        name = "bass";
	src = bass.src;
      }
      {
        name = "bobthefish";
	src = bobthefish.src;
      }
      {
        name = "fzf";
	src = fzf.src;
      }
      {
        name = "z";
	src = z.src;
      }
      {
        name = "fish";
	src = pkgs.fetchFromGitHub {
	  owner = "catppuccin";
	  repo = "fish";
          rev = "a3b9eb5eaf2171ba1359fe98f20d226c016568cf";
	  sha256 = "sha256-shQxlyoauXJACoZWtRUbRMxmm10R8vOigXwjxBhG8ng=";
	};
      }
    ];

    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      # Commands to run in interactive sessions can go here
      "fish_vi_key_bindings"

      # change cursor shape in vi mode
      "set fish_cursor_default block"
      "set fish_cursor_insert line"
      "set fish_cursor_replace_one underscore"
      "set fish_cursor_visual block"

      # enable to select complemensions with hjkl on insert mode
      "bind -M insert k \"if commandline -P; commandline -f up-line; else; commandline -i k; end\""
      "bind -M insert j \"if commandline -P; commandline -f down-line; else; commandline -i j; end\""
      "bind -M insert h \"if commandline -P; commandline -f backward-char; else; commandline -i h; end\""
      "bind -M insert l \"if commandline -P; commandline -f forward-char; else; commandline -i l; end\""

      # oh-my-fish/theme-bobthefish

      ## select bobthefish color scheme
      "set theme_color_scheme catppuccin-frappe"

      ## enable nerd font support in bobthefish
      "set -g theme_nerd_fonts yes"
    ]));
  };

  catppuccin.fish.enable = true;
}
