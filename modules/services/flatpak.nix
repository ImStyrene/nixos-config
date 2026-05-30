{ config, pkgs, lib, ... }:
{
  services.flatpak = {
    enable = true;
    package = pkgs.unstable.flatpak;
  };
}
