{
  description = "pkino's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      firefox-addons,
      nix-vscode-extensions,
      catppuccin,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        pkino = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop-dev/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pkino.imports = [
                ./home.nix
                catppuccin.homeManagerModules.catppuccin
              ];
              home-manager.extraSpecialArgs = {
                inherit firefox-addons;
                inherit nix-vscode-extensions;
                inherit pkgs;
                inherit system;
              };
            }
          ];
        };
      };
    };
}
