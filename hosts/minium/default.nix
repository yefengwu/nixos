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
    mosh
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


  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      server role = standalone server
      ;netbios name = smbnix
      ;security = user
      ;#use sendfile = yes
      ;#max protocol = smb2
      ;"hosts allow" = 192.168.0 localhost
      ;"hosts deny" = 0.0.0.0/0
      ;"guest account" = nobody
      ;"map to guest" = bad user
    '';
    shares = {
      nixos = {
        comment = "nixos shared";
        path = "/home/xuwei/share";
        ";browseable" = "yes";
        ";valid users" = "NOTUSED";
        public = "no";
        writable = "yes";
        printable = "no";
        ";read only" = "no";
        ";guest ok" = "no";
        "create mask" = "0765";
        ";directory mask" = "0755";
        "force user" = "xuwei";
        "force group" = "users";
      };
    };
  };

  networking.firewall.enable = false;
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];

  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "23.05";
}
