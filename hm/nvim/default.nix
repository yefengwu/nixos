{ config, lib, pkgs, ... }:

{
  programs = {
    neovim = {
      viAlias = true;
      vimAlias = true;
      enable = true;
      withNodeJs = true;
      withPython3 = true;
    };
  };
  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua".source = ./lua;
}
