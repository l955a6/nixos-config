{
  description = "pkino's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
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

  outputs = inputs@{ self, nixpkgs, home-manager, firefox-addons
    , nix-vscode-extensions, catppuccin, ... }: {
      nixosConfigurations = {
        pkino = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pkino.imports =
                [ ./home.nix catppuccin.homeManagerModules.catppuccin ];
              home-manager.extraSpecialArgs = {
                inherit firefox-addons;
                inherit nix-vscode-extensions;
              };
            }
          ];
        };
      };
    };
}
