# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    inputs.nixvim.homeManagerModules.nixvim
    inputs.ags.homeManagerModules.default
    
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      inputs.hyprpanel.overlay
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "gabri";
    homeDirectory = "/home/gabri";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [];
    settings = {
      exec-once = [
        "${pkgs.hyprpanel}/bin/hyprpanel"
      ];
      input = {
        kb_layout = "gb";
        numlock_by_default = true;
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0;
      };

      general = {
        monitor = [
          "eDP-1, 1920x1200@60, 0x0, 1"
        ];
        gaps_in = 4;
        gaps_out = 4;
      };

      decoration = {
        rounding = 8;
        shadow_offset = "0 5";
      };

      # mouse
      bindm = [
        # windows
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      # hold
      binde = [
        # windows
        "SUPER_CTRL, j, resizeactive, -32 0"
        "SUPER_CTRL, l, resizeactive, 32 0"
        "SUPER_CTRL, i, resizeactive, 0 -32"
        "SUPER_CTRL, k, resizeactive, 0 32"
      ];

      # standard
      bind = [
        # workspaces
        "SUPER, 1, focusworkspaceoncurrentmonitor, 1"
        "SUPER, 2, focusworkspaceoncurrentmonitor, 2"
        "SUPER, 3, focusworkspaceoncurrentmonitor, 3"
        "SUPER, 4, focusworkspaceoncurrentmonitor, 4"
        "SUPER, 5, focusworkspaceoncurrentmonitor, 5"
        "SUPER, 6, focusworkspaceoncurrentmonitor, 6"
        "SUPER, 7, focusworkspaceoncurrentmonitor, 7"
        "SUPER, 8, focusworkspaceoncurrentmonitor, 8"
        "SUPER, 9, focusworkspaceoncurrentmonitor, 9"      
        "SUPER, 0, focusworkspaceoncurrentmonitor, 1"
        "SUPER, minus, focusworkspaceoncurrentmonitor, 4"
        "SUPER, equal, focusworkspaceoncurrentmonitor, 7"     
        "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER_SHIFT, 9, movetoworkspacesilent, 9"
        "SUPER_SHIFT, 0, movetoworkspacesilent, 1"
        "SUPER_SHIFT, minus, movetoworkspacesilent, 4"
        "SUPER_SHIFT, equal, movetoworkspacesilent, 7"
        # windows
        "SUPER, Q, killactive"
        "SUPER, F, fullscreen"
        "SUPER, T, togglefloating"
        "SUPER, j, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, i, movefocus, u"
        "SUPER, k, movefocus, d"
        "SUPER_SHIFT, j, movewindow, l"
        "SUPER_SHIFT, l, movewindow, r"
        "SUPER_SHIFT, i, movewindow, u"
        "SUPER_SHIFT, k, movewindow, d"
        # run
        "SUPER, Space, exec, tofi-drun | xargs hyprctl dispatch exec --"
        # screenshot
        "SUPER, Print, exec, grimblast copy area"
        "SUPER, Insert, exec, grimblast copysave"
        # volume
        "SUPER, F1, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "SUPER, F2, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
        "SUPER, F3, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
        "SUPER, F4 ,exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        # brightness
        "SUPER, F5, exec, brightnessctl set 51-"
        "SUPER, F6, exec, brightnessctl set 51+"
        # config shortcuts
        "SUPER, F9, exec, codium /home/gabri/.src/nixos/configuration.nix"
        "SUPER, F10, exec, codium /home/gabri/.src/nixos/flake.nix"
        "SUPER, F11, exec, codium /home/gabri/.src/nixos/home.nix"
        # applications
        "SUPER, Return, exec, alacritty"
        "SUPER, slash, exec, alacritty -e btop"
        "SUPER, z, exec, thunar"
        "SUPER, x, exec, firefox"
        "SUPER_SHIFT, x, exec, firefox --private-window"
        "SUPER, c, exec, codium"
        "SUPER, v, exec, obsidian"
        "SUPER, b, exec, vesktop"
        "SUPER, m, exec, spotify"
        "SUPER, F12, exec, qalculate-qt"
        # bar
        "SUPER, grave, exec, hyprpanel -t dashboardmenu"
        "SUPER_CTRL, b, exec, hyprpanel -q && hyprpanel"
        "SUPER_SHIFT, b, exec, hyprpanel -t bar-0"
      ];
    };
  };

  programs.ags = {
    enable = true;
    # null or path, leave as null if you don't want hm to manage the config
    # configDir = ../ags;
    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  programs.tofi = {
    enable = true;
    settings = {
      horizontal = false;
      anchor = "center";
      height = "30%";
      width = "15%";
      outline-width = 0;
      border-width = 0;
      num-results = 8;
      result-spacing = 16;
      font-size = "10";
      corner-radius = "8";
    };
  };

  home.activation = {
    regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };

  # Add stuff for your user as you see fit:
  programs.git.enable = true;
  programs.lazygit.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      sdn = "shutdown now";
    };
    initExtra = "
      bindkey -M vicmd '^r' history-incremental-search-backward
      bindkey -M viins '^r' history-incremental-search-backward
      brightness () {
        for display in \${@:2}; do
          ddcutil setvcp 10 $1 --display $display
        done
      }
    ";
    prezto = {
      enable = true;
      editor.keymap = "vi";
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$username"
        "@"
        "$hostname"
        ":"
        "$directory"
        "$character"
      ];
      right_format = lib.concatStrings [
        "$nix_shell"
        "$git_status"
        "$git_branch"
        "$time"
      ];
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_root = "bold red";
        style_user = "bold red";
      };
      hostname = {
        ssh_only = false;
        format = "[$hostname]($style)";
        style = "bold yellow";
      };
      directory = {
        truncation_length = 4;
        truncate_to_repo = false;
        truncation_symbol = "../";
        read_only = "";
        format = "[$path]($style)[$read_only]($read_only_style)";
      };
      git_branch = {
        symbol = "";
        format = "[$branch(:$remote_branch)$symbol ]($style)";
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        ahead = "";
        behind = "";
        diverged = "";
      };
      character = {
        format = "$symbol ";
      };
      nix_shell = {
        format = "[($name)$symbol]($style)";
        symbol = "󱄅";
      };
      time = {
        disabled = false;
        format = "[$time]($style)";
      };
    };
  };
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    options = {
      relativenumber = true;
      number = true;
      autowrite = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      undolevels = 10000;
      mouse = "a";
    };
    autoCmd = [
      {
        command = "TransparentEnable";
        event = "VimEnter";
        once = true;
      }
    ];
    globals.mapleader = " ";
    keymaps = [
      {
        key = "<leader>h";
        action = "<Cmd>noh<CR>";
        mode = "n";
      }
      {
        key = "<leader>ff";
        action = {__raw = "require(\"telescope.builtin\").find_files";};
        mode = "n";
      }
      {
        key = "<leader>fg";
        action = {__raw = "require(\"telescope.builtin\").live_grep";};
        mode = "n";
      }
    ];
    plugins = {
      gitsigns.enable = true;
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      which-key.enable = true;
      transparent.enable = true;
    };
    highlightOverride = {
      GitSignsAdd.fg = "#${config.lib.stylix.colors.base0B}";
      GitSignsChange.fg = "#${config.lib.stylix.colors.base0D}";
      GitSignsDelete.fg = "#${config.lib.stylix.colors.base08}";
      GitSignsAdd.bg = "NONE";
      GitSignsChange.bg = "NONE";
      GitSignsDelete.bg = "NONE";
      VertSplit.bg = "NONE";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding.x = 4;
      window.padding.y = 4;
    };
  };
  programs.password-store.enable = true;
  programs.feh.enable = true;
  programs.firefox.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };

  home.packages = with pkgs; [
    pwvucontrol
    vesktop
    grimblast
    gimp
    spotify
    obsidian
    shutter
    pokeget-rs
    libreoffice-qt
    hyprpanel
  ];


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
