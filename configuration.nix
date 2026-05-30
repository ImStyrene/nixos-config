{ config, lib, pkgs, ... }:

let
  inherit (pkgs);

  importDir = dir:
    if builtins.pathExists dir then
      builtins.map (f: import (dir + "/${f}"))
        (builtins.filter
          (n: lib.hasSuffix ".nix" n && n != "default.nix")
          (builtins.attrNames (builtins.readDir dir)))
    else [];
in

{
  # === IMPORTS === #
  imports =
    [ ./hardware-configuration.nix ]
    ++ (importDir ./modules/services)
    ++ (importDir ./modules/programs);

  # === BOOT === #
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "auto";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  # === HARDWARE === #
  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # === NETWORK === #
  networking = {
    hostName = "StyreneNix";
    networkmanager.enable = true;
  };

  # === SYSTEM === #
  environment = {
    variables = {
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      # - Utilities - #
      wget
      curl
      gnumake
      file
      pipx
      stow
      xclip
      home-manager

      # - Productivity - #
      libreoffice-fresh

      # - Archive - #
      gzip
      p7zip
      zip
      unzip
      unar

      # - Development - #
      ffmpeg-full
      wine

      # - Languages - #
      python315
      python313
      lua-language-server
      libgccjit
      gcc
      rustup
      nixd
    ];
  };

  # === NIX === #
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # === FONTS === #
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # === USERS === #
  users.users.Styrene = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video"
      "input"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  # === LOCALE === #
  time.timeZone = "America/Santo_Domingo";
  console.keyMap = "us";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_DO.UTF-8";
      LC_IDENTIFICATION = "es_DO.UTF-8";
      LC_MEASUREMENT = "es_DO.UTF-8";
      LC_MONETARY = "es_DO.UTF-8";
      LC_NAME = "es_DO.UTF-8";
      LC_NUMERIC = "es_DO.UTF-8";
      LC_PAPER = "es_DO.UTF-8";
      LC_TELEPHONE = "es_DO.UTF-8";
      LC_TIME = "es_DO.UTF-8";
    };
  };

  # === VERSION === #
  system.stateVersion = "25.05";
}
