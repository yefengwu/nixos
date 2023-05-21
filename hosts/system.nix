{ config, pkgs, lib, inputs, user, ... }:
{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Shanghai";
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ zsh ];
    variables = { EDITOR = "nvim"; };
    systemPackages = with pkgs; [
      git
      gh
      gcc
      unzip
      zip
      rar
      ripgrep
      zoxide
      wget
      neofetch
      exa
      ranger
      killall
    ];
  };

  nix = {
    settings = {
      substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
}
