{ config, pkgs, username, ... }:

{
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = [ "${username}" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  buildimage = {
    name = "frpc";
    tag = "latest";
    config = {
      WordingDir = "$HOME/docker/frpc.init";
    };
  };
}
