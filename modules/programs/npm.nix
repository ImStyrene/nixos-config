{ pkgs, ... }:

{
  programs.npm = {
    enable = true;
    package = pkgs.unstable.nodejs;
  };
}
