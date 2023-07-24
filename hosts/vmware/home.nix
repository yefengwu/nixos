{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    (import ../../modules/shell) ++
    (import ../../modules/editors);

  # home = {
  #   username = "${user}";
  #   homeDirectory = "/home/${user}";
  # };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "23.05";
}
