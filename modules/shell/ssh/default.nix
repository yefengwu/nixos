{ config, lib, pkgs, user, ... }:

{
  programs.ssh = {
    enable = true;
  };
  home.file.".ssh/config".source = ./config;
}
