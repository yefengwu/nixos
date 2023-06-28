{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    # [ (import ../../../modules/desktop/sway/home.nix) ] ++
    [ (import ../../../modules/desktop/hyprland/home.nix) ] ++
    (import ../../../modules/programs/wayland) ++
    (import ../../../modules/theme/catppuccin-dark/wayland);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "23.05";
}
