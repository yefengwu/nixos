{ config, lib, pkgs, user, ... }:

{
  imports = [
    (import ./nvim)
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
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "➜";
      };
      username = {
        style_user = "green bold";
        style_root = "black bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        format = "on [$hostname](bold red) ";
        trim_at = ".companyname.com";
        disabled = false;
      };
      directory = {
        truncation_length = 16;
        truncate_to_repo = false;
      };
      container.disabled = true;
      package.disabled = true;
      git_status.disabled = true;
      git_commit.disabled = true;
      git_state.disabled = true;
      git_metrics.disabled = true;
    };
  };
}
