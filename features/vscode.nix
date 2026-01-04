{
  pkgs,
  nix-vscode-extensions,
  system,
  ...
}:
{
  programs.vscode = {
    enable = true;

    package = (
      pkgs.vscode.override {
        commandLineArgs = [
          "--ozone-platform=wayland"
          "--enable-features=WaylandWindowDecorations"
          "--enable-wayland-ime"
        ];
      }
    );

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
          "command" = [ "nixfmt" ];
        };
      };
    };

    extensions =
      let
        vscode-marketplace = nix-vscode-extensions.extensions.${system}.vscode-marketplace;
      in
      with vscode-marketplace;
      [
        # theme
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        # lsp clients
        jnoortheen.nix-ide
        scalameta.metals
        golang.go
        leanprover.lean4
        # misc
        asvetliakov.vscode-neovim
        marp-team.marp-vscode
        gera2ld.markmap-vscode
        jetpack-io.devbox
        rogalmic.bash-debug
      ];
  };
}
