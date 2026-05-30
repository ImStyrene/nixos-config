{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.unstable.git;
  };
}
