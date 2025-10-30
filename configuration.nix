{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "starfall";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  services.hardware.openrgb.enable = true;

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  hardware.nvidia = {

    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  
    open = true;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;

  };
	
  services.getty.autologinUser = "username";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.zsh.enable = true;
  
  users.users.username = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    zsh
    nitch
    vim 
    wget
    waybar
    git
    hyprpaper
    vscodium
    mako
    tofi
    htop
    nvtopPackages.full
    openrgb
    graphicsmagick
    ffmpegthumbnailer
    ghostscript
    file
    coreutils
    bibata-cursors
    nwg-look
    orchis-theme
    kora-icon-theme
    lmstudio
    grim
    slurp
    swappy
    killall
    libnotify
    glib
    hyprpicker
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.noto
  ];
  fonts.fontDir.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";

}

