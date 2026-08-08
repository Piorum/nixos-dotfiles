{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  #Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  #Networking
  networking.hostName = "starfall";
  networking.networkmanager.enable = true;

  #Time
  services.chrony = {
    enable = true;
    enableNTS = true;
    servers = [
      "time.cloudflare.com"
    ];
  };
  time.timeZone = "America/Denver";

  #Security
  security.sudo.wheelNeedsPassword = false;
  services.getty.autologinUser = "username";

  #Misc
  nixpkgs.config.allowUnfree = true;
  services.hardware.openrgb.enable = true;

  #Graphics
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  
    open = true;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;

  };

  #Sandboxing
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings.features.cdi = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
  
  #Users
  users.users.username = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  #User Programs
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  environment.systemPackages = with pkgs; [
    #Build tools
    glib
    zlib
    clang
    dotnet-sdk_10

    #Terminal
    zsh
    nitch

    #Utilities
    git
    mpv
    htop
    killall
    openrgb
    lmstudio
    coreutils
    libnotify
    vscode.fhs
    nvtopPackages.full
    #Secondary Utilities
    jq
    file
    grim
    wget
    slurp
    swappy
    ghostscript
    graphicsmagick
    ffmpegthumbnailer

    #Gaming
    lutris

    #Web
    chromium

    #Desktop Environment
    mako
    tofi
    waybar
    nwg-look
    hyprpaper
    hyprpicker
    orchis-theme
    bibata-cursors
    kora-icon-theme
  ];

  #Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.noto
    noto-fonts-cjk-sans
  ];
  fonts.fontDir.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";

}

