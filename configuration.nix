{ config, lib, pkgs, ... }:

let
  stable = pkgs;
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in

{
# ============================= #
# ========== IMPORTS ========== #
# ============================= #
  imports = [
    ./hardware-configuration.nix
  ];

# ================================ #
# ========== BOOTLOADER ========== #
# ================================ #
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev"; # For UEFI (GPT)
        gfxmodeEfi = "1920x1080";
        gfxmodeBios = "1024x768";
        splashImage = /boot/background.png;
        extraConfig = ''
        '';
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = stable.linuxPackages_zen;
  };

# =================================== #
# ========== CONFIGURATION ========== #
# =================================== #
  networking = {
    hostName = "StyreneNix";
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;

# ========================================== #
# ========== PACKAGE OVERLAYS ============== #
# ========================================== #
  nixpkgs.overlays = [
  ];

# ============================== #
# ========== SERVICES ========== #
# ============================== #
  services = {

    # ---------- System Services ---------- #
    dbus.enable = true;
    openssh.enable = true;
    blueman.enable = true;

    # ---------- Software Services ---------- #
    flatpak.enable = true;


    # ---------- X Server Support (If you want to use X11) ---------- #
    xserver = {
      enable = true;
      videoDrivers = [ "modesetting" "amdgpu" ];

      # ---------- DM/ DE / WM ---------- #
      displayManager.sddm.enable = true;
      desktopManager = {
        plasma6.enable = true;
        gnome.enable = true;
        xfce.enable = true;
      };
    };

    # ---------- Audio ---------- #
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
    };
  };

  # Resolve ssh-askpass conflict between Plasma6 and GNOME
  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

# ===================================== #
# ========== SYSTEM PACKAGES ========== #
# ===================================== #
  environment.systemPackages = with unstable; [
    # ---------- Core Utilities ---------- #
    openssh
    wget
    curl
    flatpak
    tor
    bat
    tealdeer
    python313Packages.pip
    grub2
    yazi
    powershell
    zsh
    gnumake
    scdoc
    python314
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    file
    docker
    pipx

    # ---------- IDEs ---------- #
    neovim
    vim
    helix
    vscodium

    # ---------- Work ---------- #
    libreoffice-qt6-fresh
    zoxide
    fzf
    fd
    ripgrep
    gzip
    unzip
    tmux

    # ---------- DE/WM ---------- #
    hyprland

    # ---------- Hardware ---------- #
    corectrl
    btop

    # ---------- Development ---------- #
    libgccjit
    rojo

    # ---------- Fun Stuff ---------- #
    cmatrix
    fastfetch

    # ---------- Essentials ---------- #
    wineWowPackages.stagingFull
    winetricks
    p7zip
    git
    gitui

    # ---------- Wayland Related ---------- #
    xwayland

    # ---------- Languages ---------- #
    luau
    lua-language-server
    libgccjit
    libgcc
    gcc
    go
    rustup
    nil

    # ---------- VMs ---------- #
    virtualbox
  ];

# ============================== #
# ========== PROGRAMS ========== #
# ============================== #
  programs = {
    zsh.enable = true;
    hyprland.enable = true;
    npm.enable = true;
  };

# =========================== #
# ========== FONTS ========== #
# =========================== #
  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
    ];
  };

# =========================== #
# ========== USERS ========== #
# =========================== #
  users = {
    users = {
      Styrene = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "kvm" "vboxusers" ];
        shell = unstable.zsh;
      };
    };
    extraGroups = {
      vboxusers.members = [ "Styrene" ];
    };
  };

# ========================= #
# ========== VMs ========== #
# ========================= #
  virtualisation.virtualbox = {
    host = {
    	 enable = true;
	 enableExtensionPack = true;
    };
  };

# =========================================== #
# ========== EXPERIMENTAL FEATURES ========== #
# =========================================== #
  nix.settings.experimental-features = [
    "nix-command" "flakes"
  ];

# ========================================= #
# ========== ENVIRONMENT VARIABLES ========= #
# ========================================= #
  environment.sessionVariables = {
  };

# ========================= #
# ========== XDG ========== #
# ========================= #
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

# ===================================== #
# ========== TIME AND LOCALE ========== #
# ===================================== #
  time.timeZone = "America/Santo_Domingo";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

# =================================== #
# ========== NIXOS VERSION ========== #
# =================================== =
  system.stateVersion = "25.05";
}
