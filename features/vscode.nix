{
  pkgs,
  nix-vscode-extensions,
  system,
  ...
}:
{
  programs.vscode = {
    enable = true;

    profiles.default.extensions =
      with nix-vscode-extensions.extensions.${system}.vscode-marketplace-release; [
        # theme
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        # lsp clients
        pkgs.vscode-extensions.jnoortheen.nix-ide
        scalameta.metals
        golang.go
        leanprover.lean4
        # misc
        asvetliakov.vscode-neovim
        tamasfe.even-better-toml
      ];
  };
}
