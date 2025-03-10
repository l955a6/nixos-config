{ nix-vscode-extensions, ... }: {
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
      "terminal.integrated.fontFamily" = "Cica";
    };

    extensions = let
      vscode-marketplace = nix-vscode-extensions.extensions."x86_64-linux".vscode-marketplace;
    in with vscode-marketplace; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      asvetliakov.vscode-neovim

      marp-team.marp-vscode
      gera2ld.markmap-vscode
    ];
  };
}
