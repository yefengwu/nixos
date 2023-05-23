{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./zsh
    ./nvim
    ./tmux
    ./starship
    ./ssh
  ];
  home.stateVersion = "22.11";
  programs.git = {
    enable = true;
    userName = "xuwei";
    userEmail = "franklxw@outlook.com";
  };
  programs.lazygit = {
    enable = true;
  };
}