{
  description = "Styrene's NixOS configuration";

  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pkgs_stable.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { pkgs, pkgs_stable, ... }:
  let
    system = "x86_64-linux";
    unstable = import pkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.StyreneNix = pkgs_stable.lib.nixosSystem {
      inherit system;
      modules = [
        { nixpkgs.overlays = [(final: prev: { inherit unstable; })]; }
        ./configuration.nix
      ];
    };
  };
}
