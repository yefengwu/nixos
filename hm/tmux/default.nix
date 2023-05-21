{ config, lib, pkgs, user, ... }:
{
  programs.tmux = {
    enable = true;
  };
  home.file.".config/tmux/tmux.conf".source = ./tmux.conf;
}
