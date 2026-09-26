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

  boot.kernelParams = [
    "amd_pstate=active"
    "processor.ignore_ppc=1"
    "irqaffinity=8-15,24-31"
  ];
  boot.kernelModules = [
    "tcp_bbr"
    "8021q"
  ];
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";

    "net.ipv4.tcp_notsent_lowat" = 16384;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_timestamps" = 1;

    "net.core.busy_read" = 50;
    "net.core.busy_poll" = 50;

    "net.core.netdev_max_backlog" = 16384;
    "net.core.somaxconn" = 8192;

    "vm.max_map_count" = 2147483642;
    "kernel.split_lock_mitigate" = 0;
  };

  #Optimizations
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        nv_powermode_level = "prefer-maximum-performance";
      };
      cpu = {
        # CCD0
        pin_cores = "0-7,16-23";
        park_cores = "no";
      };
    };
  };

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
  systemd.packages = [ pkgs.hyprpolkitagent ];
  systemd.user.targets.graphical-session.wants = [ "hyprpolkitagent.service" ];

  security.rtkit.enable = true;

  #Misc
  nixpkgs.config.allowUnfree = true;

  systemd.tmpfiles.rules = [
    "L+ /var/lib/OpenRGB/main.orp - - - - ${./main.orp}"
  ];
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    startupProfile = "main.orp";
  };

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
    enable32Bit = true;
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
    extraPackages = with pkgs; [
      gamemode
    ];
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

