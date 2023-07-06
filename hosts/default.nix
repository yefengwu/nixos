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
      ./minium/wayland
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
              (import ./minium/wayland/home.nix)
            ] ++ [
              inputs.hyprland.homeManagerModules.default
            ];
          };
        };
        nixpkgs = {
          overlays =
            [
              self.overlays.default
              #  inputs.neovim-nightly-overlay.overlay
              #  inputs.rust-overlay.overlays.default
              #  inputs.picom.overlays.default
              #  inputs.nil.overlays.default
              #  inputs.joshuto.overlays.default
              #  inputs.nixd.overlays.default
              # (import inputs.emacs-overlay)
            ]
            ++ (import ../overlays);
        };
      }
    ];
  };
  vmware = lib.nixosSystem {
    # Laptop profile
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./vmware
    ] ++ [
      ./system.nix
    ] ++ [
      inputs.impermanence.nixosModules.impermanence
      inputs.nur.nixosModules.nur
      inputs.sops-nix.nixosModules.sops
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.disko
      # inputs.joshuto.overlays.default
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = {
            imports = [
              (import ./vmware/home.nix)
            ];
          };
        };
        nixpkgs = {
          overlays =
            [
              self.overlays.default
              #  inputs.neovim-nightly-overlay.overlay
              #  inputs.rust-overlay.overlays.default
              #  inputs.picom.overlays.default
              #  inputs.nil.overlays.default
              inputs.joshuto.overlays.default
              #  inputs.nixd.overlays.default
              # (import inputs.emacs-overlay)
            ]
            ++ (import ../overlays);
        };
      }
    ];
  };

}
