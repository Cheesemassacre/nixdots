{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "marin";
  home.homeDirectory = "/home/marin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/marin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  services.picom = {
    enable = true;
    vSync = true;
    backend = "glx";
  };

  
  services.dunst = {
    enable = true;
    settings.global = {
      font = "Monospace 10";
      frame_color = "#241571";
    };
    settings = {
      urgency_normal = {
      background = "#000000";
    foreground = "#ffffff";
      timeout = 15;
     };
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Tango Dark";
    settings = {
      font_family  =    "Hack";
      italic_font  =    "Hack Italic";
      bold_font   =     "Hack Bold";
      bold_italic_font = "Hack Bold Italic";
      confirm_os_window_close = 0;
      background_opacity = "0.3";
      window_logo_path = "/home/marin/Pictures/pngwing.com(1)(1).png";
      window_logo_position = "bottom-right";
      window_logo_alpha = "0.6";
      window_margin_width = 5;
    };
  };
  
  gtk.enable = true;

  gtk.gtk3.extraConfig = {
    gtk-theme-name = "Material-Black-Blueberry";
    gtk-icon-theme-name = "Tela-blue-dark";
  };

  services.sxhkd = {
    enable = true;
    extraConfig = ''
    super + e ; w ; w ; w
        floorp
    super + e ; t 
      thunar
        
    super + e ; p ; r ; o
      ./processkiller.sh &

    super + e ; s ; p
        spotify

    super + e ; p ; k
        floorp -- https://search.nixos.org/packages

    super + shift + plus
        pamixer -i 5 

    super + shift + apostrophe
        pamixer -d 5 

    super + e ; d ; i
        vencorddesktop

    super + c
        qalculate-gtk

    super + s
        xfce4-screenshooter

    super + n
        st -e vim Notes

    super + shift + e
        ./poweopt.sh &

    super + e ; w ; a ; l
        ./wallpapers.sh &

    super + shift + s
        ./sleep.sh &

    super + shift + r
        rofi -show drun
     
     '';
  };
  

  




  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
