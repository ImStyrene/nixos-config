{ pkgs, ... }:

{
  programs.corectrl = {
    enable = true;
    package = pkgs.unstable.corectrl;
  };
}
