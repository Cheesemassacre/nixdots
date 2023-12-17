# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./unstable.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Network.
  networking.hostName = "nixospicek"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Zagreb";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hr_HR.UTF-8";
    LC_IDENTIFICATION = "hr_HR.UTF-8";
    LC_MEASUREMENT = "hr_HR.UTF-8";
    LC_MONETARY = "hr_HR.UTF-8";
    LC_NAME = "hr_HR.UTF-8";
    LC_NUMERIC = "hr_HR.UTF-8";
    LC_PAPER = "hr_HR.UTF-8";
    LC_TELEPHONE = "hr_HR.UTF-8";
    LC_TIME = "hr_HR.UTF-8";
  };
  
  # Keyboard.
  services.xserver = {
    layout = "hr";
    xkbVariant = "";
  };
  
  # Configure console keymap.
  console.keyMap = "croat";

  # Fish shell.
  # programs.fish.enable = true;
  
  #  Display Manager.
  services.xserver.displayManager = {
	lightdm.enable = true;
  	autoLogin = {
		enable = true;
		user = "marin";
	};
  }; 

  # Services/other.
  virtualisation.libvirtd.enable = true; 
  services.flatpak.enable = true;
  services.dbus.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  # Hyprland
  # programs.hyprland.enable = true;
  # Optional, hint electron apps to use wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # services.xserver.windowManager.windowmaker.enable = true;
  # services.xserver.windowManager.openbox.enable = true;
  # services.xserver.windowManager.fluxbox.enable = true;
  # services.xserver.windowManager.i3.enable = true;
  # services.xserver.windowManager.herbstluftwm.enable = true;
  # services.xserver.windowManager.berry.enable = true;
  

  xdg.portal.config.common.default = "*";
  

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    
    };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marin = {
     isNormalUser = true;
     description = "marin";
     extraGroups = [ "wheel" "kvm" "input" "disk" "libvirtd" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
    alacritty
    deluge-gtk
    dmenu
    dunst
    dwm
    feh
    # fish
    fontconfig
    freetype
    gcc
    git
    gnome.gedit
    gnugrep
    gnumake
    gparted
    libverto
    lxappearance
    mate.engrampa
    neofetch
    neovim
    ninja
    nodejs
    pamixer
    pavucontrol
    polkit_gnome
    ripgrep
    rofi
    spotify
    stdenv
    sxhkd
    terminus-nerdfont
    tldr
    unzip
    vim
    vscodium
    w3m
    wget
    xclip
    xdg-desktop-portal-gtk
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXft
    xorg.libXinerama
    xorg.xhost
    xorg.xinit
    xorg.xinput
    xorg.xsetroot
    barrier
    xfce.xfce4-screenshooter
    xfce.thunar
    kitty
    htop
    psmisc
    vlc
    libnotify
    obs-studio
    picom
    nicotine-plus
    unzip
    imv
    qalculate-gtk
    mc
    ranger
    tty-clock
    cava
    cmatrix
    pfetch
    mpv
    brave
    gnome-multi-writer
    rhythmbox
    espanso
    etcher
    xfce.xfconf
	
  ];

  # Electron out of date
  nixpkgs.config.permittedInsecurePackages = [
                "electron-19.1.9"
              ];

  # Dwm and dmenu compile.
  nixpkgs.overlays = [
	(final: prev: {
		dwm = prev.dwm.overrideAttrs (old: { src = /home/marin/dwm ;});
    dmenu = prev.dmenu.overrideAttrs (old: { src = /home/marin/dmenu ;});
    # slstatus = prev.slstatus.overrideAttrs (old: { src = /home/marin/slstatus ;});

	})
  ];
  
  
  # XDG portal.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
 

  # Polkit.
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  }; 

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  networking.enableIPv6 = false;

  # Fonts.
  fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        font-awesome
        hack-font
        source-han-sans
        (nerdfonts.override { fonts = [ "Meslo" "FiraMono" ]; })
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "Hack" ];
          serif = [ "Noto Serif" ];
          sansSerif = [ "Noto Sans" ];
        };
      };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;
  system.autoUpgrade.enable = false;  
  system.autoUpgrade.allowReboot = false; 
  
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
