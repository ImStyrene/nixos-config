{ config, pkgs, lib, ... }:
{
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };
}
