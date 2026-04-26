{
  pkgs,
  nix-vscode-extensions,
  system,
  ...
}:
{
  programs.vscode = {
    enable = true;

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
        cab404.vscode-direnv
      ];
  };
}
