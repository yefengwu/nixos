{ pkgs, username, ... }: {
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking = {
    hostName = "minium";
    networkmanager.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    hashedPassword = "$6$H4uVu105iaTFUNr6$LXi33OjyiRKiY9L4RLVmEIoYYVNLApbbwf/5Q/GtOL.LurJlufYfInoPSrsoFfVa/vqi8Gt8Elu0eOyzxL2WC1";
    extraGroups = [ "docker" "wheel" ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    settings.PasswordAuthentication = true;
    # I'll disable this once I can connect.
  };
  services.samba = {
    enable = true;
    shares."nixos" = {
      path = "home/xuwei";
      browseable = true;
      writable = true;
      printable = false;
      guestOk = false;
      createMask = "0644";
      directoryMask = "0755";
      validUsers = [ "xuwei" ];
      writeList = [ "xuwei" ];
    };
  };

  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "23.05";
}
