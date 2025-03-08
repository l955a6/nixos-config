{ pkgs, config, catppuccin, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      general.live_config_reload = true;

      scrolling.history = 10000;

      env.TERM = "xterm-256color";

      window.decorations = "Buttonless";

      font = {
        size = 22;

        glyph_offset = {
          x = 0;
	  y = 0;
        };

	normal = {
	  family = "Cica";
	  style = "Regular";
	};

	bold = {
	  family = "Cica";
	  style = "Bold";
	};

	italic = {
	  family = "Cica";
	  style = "Italic";
	};

	bold_italic = {
	  family = "Cica";
	  style = "Bold Italic";
	};
      };
    };
  };

  catppuccin.alacritty.enable = true;
}
