{ config, pkgs, lib, ... }:
{
  services.openssh = {
    enable = true;
    package = pkgs.unstable.openssh;
  };
}
