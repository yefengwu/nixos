{ pkgs
, username
, ...
}: {
  # 主要区别就是这个 wsl 模块
  # 其实就是抄这里 https://github.com/nix-community/NixOS-WSL/blob/main/configuration.nix
  wsl = {
    enable = true;
    defaultUser = "${username}";
    # 创建软件的桌面快捷方式
    startMenuLaunchers = true;
  };
  networking = {
    hostName = "wsl"; # Define your hostname.
    networkmanager.enable = true;
  };


  environment.systemPackages = with pkgs; [
    tree
    file
    wsl-open
    nix-bash-completions
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

  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "22.11";
}
