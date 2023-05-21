{ config, lib, pkgs, user, ... }:
{
  programs.starship = {
    enable = true;
  };
  home.file.".config/starship.toml".source = ./starship.toml;
}
