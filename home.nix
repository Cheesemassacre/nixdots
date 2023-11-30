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

 /*  programs.kitty = {
    enable = true;
    theme = "~/.config/kitty/theme.conf";
    settings = {
      font_family  =    "Hack";
      italic_font  =    "Hack Italic";
      bold_font    =    "Hack Bold";
      bold_italic_font = "Hack Bold Italic";
      confirm_os_window_close = 0;
      background_opacity = "1.0";
      # window_logo_path = "/home/marin/Pictures/pngwing.com(1)(1).png";
      window_logo_position = "bottom-right";
      window_logo_alpha = "0.8";
      window_margin_width = 5;
    };
  }; */
  
  gtk = {
    enable = true;
    gtk3.extraConfig = {
    gtk-theme-name = "Material-Black-Blueberry";
    gtk-icon-theme-name = "Tela-grey-dark";
    };
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

    super + b
        pavucontrol

    super + e ; d ; i
        vencorddesktop

    super + s
        xfce4-screenshooter

    super + shift + e
        ./poweopt.sh &

    super + d
        rofi -show drun

     
     '';
  };
  
  programs.bash = {
    enable = true;
    shellAliases = {
    ".." = "cd ..";
    "c" = "clear";
  };
    bashrcExtra = ''
    eval "$(oh-my-posh init bash --config ~/.config/theme.omp.json)"
  '';
  };

    xsession = {
    enable = true;
    profileExtra = ''
    sxhkd &
    feh --bg-scale /home/marin/Pictures/wallhaven-3l6xw6.png
    /home/marin/dwm-bar/dwm_bar.sh &
    polybar topleft &
    polybar botright &
    polybar workind &
  '';
  }; 

  services.polybar.enable = true;

  services.polybar.config = {
  "colors" = {
    background = "#000000";
    background-alt = "#000000";
    foreground = "#C5C8C6";
    primary = "#C5C8C6";
    secondary = "#8ABEB7";
    alert = "#A54242";
    disabled = "#707880";
    text = "#000000";
      };



    "bar/topleft" = {
    width = "9%";
    height = "24pt";
    radius = 0;


    background = "#000000";
    foreground = "#C5C8C6";

    line-size = "3pt";

    border-size = "2pt";
    border-color = "#C5C8C6";

    padding-left = 0;
    padding-right = 1;

    module-margin = 1;

    separator = "|";
    separator-foreground = "#707880";

    font-0 = "NotoSans:weight=bold;2";
    modules-center = "cpu memory";


    cursor-click = "pointer";
    cursor-scroll = "ns-resize";

    override-redirect = "true";

    bottom = "true";

    enable-ipc = "true";
    };

    "bar/botright" = {
    width = "9%";
    height = "24pt";
    radius = 0;

    bottom = "true";

    offset-x = "91%";

    background = "#000000";
    foreground = "#C5C8C6";

    line-size = "3pt";

    border-size = "2pt";
    border-color = "#C5C8C6";

    padding-left = 0;
    padding-right = 1;

    module-margin = 1;

    separator = "|";
    separator-foreground = "#707880";

    font-0 = "NotoSans:weight=bold;2";
    modules-center = "date ";


    cursor-click = "pointer";
    cursor-scroll = "ns-resize";

    enable-ipc = "true";

    wm-restack = "generic";

    override-redirect = "true";

    };

    "bar/workind" = {
    width = "2%";
    height = "24pt";
    radius = 0;


    background = "#C5C8C6";
    foreground = "#000000";




    line-size = "0pt";

    border-size = "2pt";
    border-color = "#000000";

    padding-left = 0;
    padding-right = 1;

    module-margin = 1;

    separator = "|";
    separator-foreground = "#707880";

    font-0 = "NotoSans:weight=bold;2";
    font-1 = "NotoSansCJKJP:style=bold:antialias=true;2";
    modules-center = "xworkspaces";


    cursor-click = "pointer";
    cursor-scroll = "ns-resize";

    override-redirect = "true";
    };

    "module/xworkspaces" = {
    type = "internal/xworkspaces";

    label-active = "%name%";
    label-active-background = "#C5C8C6";
    label-active-underline= "#C5C8C6";
    label-active-padding = 1;

    label-occupied = "";
    label-occupied-padding = 1;

    label-urgent = "%name%";
    label-urgent-background = "#A54242";
    label-urgent-padding = 1;

    label-empty = "";
    label-empty-foreground = "#707880";
    label-empty-padding = 1;
    label-active-font = 2;
    };



    "module/memory" = {
    type = "internal/memory";
    interval = 2;
    format-prefix = "RAM ";
    format-prefix-foreground = "#C5C8C6";
    label = "%percentage_used:2%%";
    label-active-font = 1;
    };


    "module/cpu" = {
    type = "internal/cpu";
    interval = 2;
    format-prefix = "CPU ";
    format-prefix-foreground = "#C5C8C6";
    label = "%percentage:2%%";
    label-active-font = 1;
    };

    "module/date" = {
    type = "internal/date";
    interval = 1;

    date = "%H:%M";
    date-alt = "%d-%m %H:%M";

    label = "%date%";
    label-foreground = "#C5C8C6";
    label-active-font = 1;
    };

    "settings" = {
    screenchange-reload = "true";
    pseudo-transparency = "false";
    };
  };

  services.polybar.script = ''
    "polybar topleft &amp;"
    "polybar botright &amp;"
    "polybar workind &amp;"
  ''
  ;
 
  




  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
