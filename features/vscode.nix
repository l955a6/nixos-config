{
  pkgs-unstable,
  nix-vscode-extensions,
  system,
  ...
}:
{
  programs.vscode = {
    enable = true;

    package = pkgs-unstable.vscode;

    profiles.default.extensions =
      with nix-vscode-extensions.extensions.${system}.vscode-marketplace-release; [
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
        tamasfe.even-better-toml
      ];
  };
}
