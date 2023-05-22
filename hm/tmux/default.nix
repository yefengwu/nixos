{ config, lib, pkgs, user, ... }:
{
  programs.tmux = {
    enable = true;
  };
  home.file.".tmux.conf".source = ./tmux.conf;
  home.file.".tmux.conf.local".source = ./tmux.conf.local;
}
