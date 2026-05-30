{ config, pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    desktopManager = {
      lxqt.enable = true;
      xfce = {
        enable = true;
        enableWaylandSession = true;
      };
    };
  };
}
