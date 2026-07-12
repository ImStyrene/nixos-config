{ config, pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    desktopManager.lxqt.enable = true;
  };
}
