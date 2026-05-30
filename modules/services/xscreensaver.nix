{ pkgs, ... }:

{
  services.xscreensaver = {
    enable = true;
    package = pkgs.xscreensaver;
  };
}
