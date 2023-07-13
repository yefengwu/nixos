{ config, pkgs, username, ... }:

{
  virtualisation = {
    oci-containers.containers = {
      jupyterlab = {
        autoStart = true;
        image = "jupyter/base-notebook";
        ports = [ "8888:8888" ];
        volumes = [ "/home/xuwei/jupyterlab:/home/jovyan/work" ];
        # user = "xuwei:users";
        environment = {
          JUPYTER_ENABLE_LAB = "yes";
        };
      };
    };
  };
}
