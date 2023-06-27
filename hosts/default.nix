{ system, self, nixpkgs, inputs, user, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
  minium = lib.nixosSystem {
    # Laptop profile
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./minium/default.nix
      # ./laptop/wayland #hyprland and sway,go to this dir,choose one
      # ./laptop/x11 #only bspwm
    ] ++ [
      ./system.nix
    ] ++ [
      inputs.impermanence.nixosModules.impermanence
      inputs.nur.nixosModules.nur
      inputs.hyprland.nixosModules.default
      inputs.sops-nix.nixosModules.sops
      inputs.disko.nixosModules.disko
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = {
            imports = [
              (import ../hm/default.nix)
            ];
          };
        };
      }
    ];
  };
}
