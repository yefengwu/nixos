{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./zsh
    ./nvim
    ./tmux
    ./starship
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
  programs.ssh = {
    enable = true;
  };
}
