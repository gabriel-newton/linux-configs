# gtnbr nix config file

{ config, pkgs, inputs, outputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      gabri = import ./home.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Flake
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Enable networking
  networking.hostName = "gtnbr-nixos"; # Define your hostname.
  networking.resolvconf.enable = false;
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  # networking.networkmanager.insertNameservers = ["9.9.9.9"];
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gabri = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDYIKVVml24dM+vBodC5+yD8cHN+m4WUtzrg8EAr68mw nathan@natpc" ];
    description = "gabri";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  
  # upower
  services.upower.enable = true;

  # Thunar
  programs.thunar.enable = true;

  # Nix Helper
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "hourly";
      extraArgs = "--keep 5";
    };
    flake = "/home/gabri/.src/nixos";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    tree
    fd
    ripgrep
    unzip
    gnupg
    gpg-tui
    pinentry-curses
    btop
    htop
    tmux
    dig
    wl-clipboard-rs
    ddcutil
    fastfetch
    speedtest-cli
    cargo
    rustc
    rustup
    python3
    swww
    pipewire
    libgtop
    bluez
    # bluez-utils
    grimblast
    gpu-screen-recorder
    hyprpicker
    matugen
    wl-clipboard
    dart-sass
    brightnessctl
    wev
    qalculate-qt
    rclone
    rclone-browser
    # upower
    # gnome-bluetooth-3.0
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  # services.xserver.enable = true;
  # services.pipewire.enable = true;
  # services.pipewire.pulse.enable = true;
  services.hardware.openrgb.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  # Stylix
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-terminal-dark.yaml";
  stylix.image = ./wallpapers/music-wallpapers/ti.png;
  stylix = {
    polarity = "dark";
    cursor = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 24;
    };
    fonts = {
      sizes = {
        terminal = 10;
        desktop = 8;
        applications = 10;
        popups = 10;
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font Mono";
      };
      emoji = {
        package = pkgs.noto-fonts;
        name = "Noto Color Emoji";
      };
    };
    opacity = {
      desktop = 0.8;
      terminal = 0.8;
    };
  };

  # Startup stuff
  systemd.user.services.SwwwDaemon = {
    enable = true;
    wantedBy = ["hyprland-session.target"];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/swww-daemon";
    };
  };
  systemd.user.services.autostartup = {
    enable = true;
    wantedBy = ["hyprland-session.target"];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/swww img /home/gabri/.src/nixos/wallpapers/music-wallpapers/ti.png --transition-step 255";
      ExecEnd = "/run/current-system/sw/bin/swww img /home/gabri/.src/nixos/wallpapers/music-wallpapers/ti.png --transition-step 255";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # }
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
