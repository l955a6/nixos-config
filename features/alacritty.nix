{ pkgs, config, ... }: {
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

      # Catppuccin Frappe
      # from https://github.com/catppuccin/alacritty/blob/main/catppuccin-frappe.toml
      colors = {
        primary = {
	  background = "#303446";
          foreground = "#c6d0f5";
          dim_foreground = "#838ba7";
          bright_foreground = "#c6d0f5";
	};

	cursor = {
	  text = "#303446";
          cursor = "#f2d5cf";
	};

	vi_mode_cursor = {
	  text = "#303446";
          cursor = "#babbf1";
	};

	search = {
	  matches = {
            foreground = "#303446";
            background = "#a5adce";
	  };

	  focused_match = {
	    foreground = "#303446";
            background = "#a6d189";
	  };
	};

	footer_bar = {
	  foreground = "#303446";
          background = "#a5adce";
	};

	hints = {
	  start = {
	    foreground = "#303446";
            background = "#e5c890";
	  };

	  end = {
	    foreground = "#303446";
            background = "#a5adce";
	  };
	};

	selection = {
	  text = "#303446";
          background = "#f2d5cf";
	};

	normal = {
	  black = "#51576d";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#b5bfe2";
	};

	bright = {
	  black = "#626880";
          red = "#e78284";
          green = "#a6d189";
          yellow = "#e5c890";
          blue = "#8caaee";
          magenta = "#f4b8e4";
          cyan = "#81c8be";
          white = "#a5adce";
	};

	indexed_colors = [
	  {
	    index = 16;
            color = "#ef9f76";
	  }
	  {
	    index = 17;
            color = "#f2d5cf";
	  }
	];
      };
    };
  };
}
