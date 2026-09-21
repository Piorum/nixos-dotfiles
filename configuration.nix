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
  security.polkit.enable = true;
  security.rtkit.enable = true;

  #Misc
  nixpkgs.config.allowUnfree = true;
  services.hardware.openrgb.enable = true;
  services.udev.extraRules = ''
    # Wooting
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1342", MODE="0660", GROUP="input", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", MODE="0660", GROUP="input", TAG+="uaccess"
    # Finalmouse
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="361d", ATTRS{idProduct}=="0100", MODE="0660", GROUP="input", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="361d", MODE="0660", GROUP="input", TAG+="uaccess"
  '';

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

  #Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."99-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 44100 48000 96000 192000 ];

        "default.clock.quantum" = 64;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 128;
      };
    };

    extraConfig.pipewire-pulse."99-low-latency" = {
      "pulse.properties" = {
        "pulse.min.req" = "32/48000";
        "pulse.default.req" = "64/48000";
        "pulse.max.req" = "128/48000";
        "pulse.min.quantum" = "32/48000";
        "pulse.max.quantum" = "128/48000";
      };
    };
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
    extraGroups = [ "wheel" "docker" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  #User Programs
  programs.hyprland = {
    enable = true;
    withUWSM = true;
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
    dotnet-sdk_11

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
    hyprpolkitagent
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

