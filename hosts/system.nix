{ config, pkgs, lib, inputs, user, ... }:
{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Shanghai";
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      gcc
      unzip
      zip
      rar
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
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
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
