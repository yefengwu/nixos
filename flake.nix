{
  description = "xuwei's NixOS Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self, nixpkgs, home-manager, ... }: {
      nixosConfigurations."minium" =
        let
          username = "xuwei";
        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs username; };
          modules = [
            ./hosts/minium
            ./hosts/system.nix
            # ./modules/virtualisation

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.${username}.imports = [
                ./hm/default.nix
              ];
            }
          ];
        };
    };
}
