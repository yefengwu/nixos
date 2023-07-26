{ config, pkgs, user, inputs, lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/desktop/gnome
      # ../../modules/virtualisation/docker
      # ../services/gitea.nix
      ../services/samba.nix
      # ../../secrets
    ];

  # boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  virtualisation.vmware.guest.enable = true;

  networking = {
    hostName = "vmware";
    networkmanager.enable = true;
    extraHosts = ''
      192.168.33.50 lab.in.com
      192.168.33.50 ng.in.com
      192.168.33.50 clash.in.com
      192.168.33.50 nas.in.com
      192.168.33.50 pve.in.com
      192.168.33.50 git.in.com
    '';
  };

  environment.systemPackages = with pkgs; [
    nushell
    joshuto
    file
    tree
    neovim
    file
    mosh
    rclone
    tmux
    zellij
  ];

  users.users.root = {
    initialHashedPassword = "$6$H4uVu105iaTFUNr6$LXi33OjyiRKiY9L4RLVmEIoYYVNLApbbwf/5Q/GtOL.LurJlufYfInoPSrsoFfVa/vqi8Gt8Elu0eOyzxL2WC1";
  };
  # zsh
  # programs.nushell.enable = true;
  users.defaultUserShell = pkgs.nushell;
  virtualisation.docker.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    # passwordFile = config.age.secrets.secret1.path;
    hashedPassword = "$6$H4uVu105iaTFUNr6$LXi33OjyiRKiY9L4RLVmEIoYYVNLApbbwf/5Q/GtOL.LurJlufYfInoPSrsoFfVa/vqi8Gt8Elu0eOyzxL2WC1";
    extraGroups = [ "docker" "wheel" ];
    packages = with pkgs; [
      bitwarden-cli
      nodePackages.gitmoji-cli
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqZLefe+elB4zshYB722ZYCaxBsEyZWvaYy3PQmSUP2 franklxw@outlook.com"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    settings.PasswordAuthentication = true;
    extraConfig = "PrintLastLog no";
    # I'll disable this once I can connect.
  };

  security.sudo = {
    enable = false;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

  time.timeZone = "Asia/Shanghai";
  system.stateVersion = "23.05";
}
