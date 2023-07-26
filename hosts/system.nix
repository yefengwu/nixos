{ config, pkgs, lib, inputs, user, ... }:
{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Shanghai";
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ nushell ];
    variables = { EDITOR = "nvim"; };
    systemPackages = with pkgs; [
      inputs.agenix.packages."${system}".default
      bat
      chezmoi
      delta
      fzf
      nodejs
      fd
      git
      gh
      gcc
      lazygit
      lazydocker
      gnumake
      unzip
      zip
      rar
      ripgrep
      zoxide
      fd
      wget
      neofetch
      exa
      ranger
      joshuto
      starship
      killall
    ];
  };

  services.dbus.enable = true;

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
