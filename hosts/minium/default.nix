{ pkgs, username, ...}: {
  networking = {
    hostName = "minium";
    networkmanager.enable = true;
  };


  environment.systemPackages = with pkgs; [
    tree
    file
    kitty
  ];

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  virtualisation.docker.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "docker" ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    # I'll disable this once I can connect.
  };

  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "23.05";
}
