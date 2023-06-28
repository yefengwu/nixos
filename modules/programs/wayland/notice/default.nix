{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    defaultTimeout = 3;
  };
}
