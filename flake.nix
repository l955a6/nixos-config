{
  description = "l955a6's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/fd5c5549692ff4d2dbee1ab7eea19adc2f97baeb";
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
        desktop-dev = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop-dev/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.l955a6.imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
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

        xps9320 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/xps9320/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.l955a6.imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
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
