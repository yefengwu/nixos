{
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
}
