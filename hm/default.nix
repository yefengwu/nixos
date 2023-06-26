{ config, lib, pkgs, user, ... }:

{
  imports = [
    ./zsh
    ./nvim
    ./tmux
    ./starship
    ./ssh
    ./alacritty
  ];
  home.stateVersion = "23.05";
  programs.git = {
    enable = true;
    userName = "xuwei";
    userEmail = "franklxw@outlook.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
  programs.lazygit = {
    enable = true;
  };
}
