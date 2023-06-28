{ config, lib, pkgs, user, ... }:
{
  programs.alacritty = {
    enable = true;
  };
  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
}
