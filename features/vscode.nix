{ pkgs, nix-vscode-extensions, ... }: {
  programs.vscode = {
    enable = true;

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Frappé";
      "workbench.iconTheme" = "catppuccin-frappe";

      "window.zoomLevel" = 2;

      "editor.formatOnSave" = true;
      "editor.rulers" = [ 100 ];
      "editor.fontFamily" = "Cica";
      "editor.fontSize" = 22;
      "editor.renderWhitespace" = "boundary";
      "terminal.integrated.fontFamily" = "Cica";
      "files.eol" = "\n";

      # Nix IDE config
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      "nix.serverSettings" = {
        "formatting" = {
	  "command" = ["nixfmt"];
	};
      };
    };

    extensions = let
      vscode-marketplace =
        nix-vscode-extensions.extensions."x86_64-linux".vscode-marketplace;
    in with vscode-marketplace; [
      # theme
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      # lsp clients
      jnoortheen.nix-ide
      # misc
      asvetliakov.vscode-neovim
      marp-team.marp-vscode
      gera2ld.markmap-vscode
    ];
  };
}
