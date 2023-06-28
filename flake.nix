{
  description = "xuwei's NixOS Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nil.url = "github:oxalica/nil";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";
    disko.url = "github:nix-community/disko";
    emanote.url = "github:srid/emanote";
    joshuto.url = "github:kamiyaa/joshuto";
    nur.url = "github:nix-community/NUR";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    lanzaboote = {
      #please read this doc -> https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md 
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, flake-parts, ... }:
    let
      user = "xuwei";
      selfPkgs = import ./pkgs;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake = {
        overlays.default = selfPkgs.overlay;
        nixosConfigurations = (
          import ./hosts {
            system = "x86_64-linux";
            inherit nixpkgs self inputs user;
          }
        );
      };
      perSystem = { config, inputs', pkgs, system, lib, ... }:
        { };
    };
}
