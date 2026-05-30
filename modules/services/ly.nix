{ config, pkgs, lib, ... }:
{
  services.displayManager.ly = {
    enable = true;
    x11Support = true;
  };
}
