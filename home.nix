{ pkgs, ... }:

{
  home.username = "ravyc";
  home.homeDirectory = "/home/ravyc";
  home.stateVersion = "26.05";

  home.file.".config/picom/picom.conf".text = ''
    shadow = true;
    shadow-radius = 0;
    shadow-offset-x = 6;
    shadow-offset-y = 6;
    shadow-color = "#1e1e2e";

    fading = true;
    fade-in-step = 0.03;
    fade-out-step = 0.03;

    frame-opacity = 0.7;

    corner-radius = 0;

    backend = "glx";
    dithered-present = false;
    vsync = true;

    detect-rounded-corners = true;
    detect-client-opacity = true;
    detect-transient = true;
    use-damage = true;

    rules: ({
      match = "window_type = 'tooltip'";
      fade = false;
      shadow = true;
      opacity = 0.55;
      full-shadow = false;
    }, {
      match = "window_type = 'dock'    || "
              "window_type = 'desktop' || "
              "_GTK_FRAME_EXTENTS@";
    }, {
      match = "window_type != 'dock'";
    }, {
      match = "window_type = 'dock' || "
              "window_type = 'desktop'";
      corner-radius = 0;
    }, {
      match = "name = 'Notification'   || "
              "class_g = 'Conky'        || "
              "class_g ?= 'Notify-osd' || "
              "class_g = 'Cairo-clock' || "
              "_GTK_FRAME_EXTENTS@";
      shadow = false;
    })
  ''; 

home.file.".config/betterlockscreen/betterlockscreenrc".text = ''

fx_list=(dim blur dimblur pixel dimpixel)
dim_level="40"
blur_level="1"

font="TerminessNerdFont"
insidecolor="11111b00"
ringcolor="89b4faff"
keyhlcolor="89b4faff"
bshlcolor="f38ba8ff"

veriftext="[checking]"
verifcolor="89b4faff"
timecolor="89b4faff"
datecolor="cdd6f4ff"
wrongtext="[incorrect]"
wrongcolor="f38ba8ff"
'';

  home.file.".config/rofi/config.rasi".text = ''
    configuration {
        modi: "drun,run,window";
        show-icons: true;
        icon-theme: "Papirus";
        terminal: "st";
        drun-display-format: "{icon} {name}";
        location: 0;
        disable-history: false;
        hide-scrollbar: true;
        display-drun: " [apps] ";
        display-run: " [run] ";
        display-window: " [window] ";
    }

    * {
        font: "TerminessNerdFont 12";
        bg: #11111b;
        accent: #89b4fa;

        background-color: transparent;
        text-color: #cdd6f4;

        margin: 0;
        padding: 0;
        spacing: 0;
    }

    window {
        width: 30%;
        background-color: @bg;
        border: 1px;
        border-color: @accent;
        border-radius: 0px;
        padding: 12px;
    }

    mainbox {
        background-color: @bg;
    }

    inputbar {
        spacing: 8px; 
        padding: 8px;
        background-color: @bg;
        text-color: @accent;
        children: [ prompt, entry ];
    }

    prompt {
        background-color: @accent;
        text-color: @bg;
        padding: 6px;
        border-radius: 0px;
    }

    entry {
        background-color: @bg;
        text-color: #cdd6f4;
        padding: 6px;
    }

    listview {
        lines: 8;
        columns: 1;
        fixed-height: false;
        border: 0px;
        spacing: 4px;
        margin: 8px 0px 0px 0px;
        background-color: @bg;
    }

    element,
    element normal.normal,
    element normal.urgent,
    element normal.active,
    element alternate.normal,
    element alternate.urgent,
    element alternate.active {
        background-color: @bg;
        text-color: #cdd6f4;
        padding: 8px;
        border-radius: 0px;
    }

    element selected.normal,
    element selected.urgent,
    element selected.active {
        background-color: @accent;
        text-color: @bg;
    }

    element-text, element-icon {
        background-color: inherit;
        text-color: inherit;
        vertical-align: 0.5;
    }

    element-icon {
        size: 24px;
        margin: 0px 8px 0px 0px;
    }
  '';

  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "type": "file",
        "source": "/home/ravyc/.config/fastfetch/halflife.txt",
        "color": {
          "1": "yellow"
        },
        "padding": {
          "top": 1,
          "right": 3
        }
      },
      "display": {
        "separator": " ",
        "color": {
          "keys": "yellow"
        }
      },
      "modules": [
        "title",
        {
          "type": "custom",
          "format": "──────────────────────────────────────────────"
        },
        {
          "type": "os",
          "key": "[os]",
          "keyColor": "yellow"
        },
        {
          "type": "kernel",
          "key": "[kernel]",
          "keyColor": "yellow"
        },
        {
          "type": "uptime",
          "key": "[uptime]",
          "keyColor": "yellow"
        },
        {
          "type": "packages",
          "key": "[packages]",
          "keyColor": "yellow"
        },
        {
          "type": "wm",
          "key": "[wm]",
          "keyColor": "yellow"
        },
        {
          "type": "terminal",
          "key": "[terminal]",
          "keyColor": "yellow"
        },
        {
          "type": "cpu",
          "key": "[cpu]",
          "keyColor": "yellow"
        },
        {
          "type": "gpu",
          "key": "[gpu]",
          "keyColor": "yellow"
        },
        {
          "type": "memory",
          "key": "[memory]",
          "keyColor": "yellow"
        },
        {
          "type": "disk",
          "key": "[disk]",
          "keyColor": "yellow"
        },
        {
          "type": "custom",
          "format": "──────────────────────────────────────────────"
        },
        {
          "type": "colors",
          "symbol": "circle"
        }
      ]
    }
  '';

  programs.bash = {
    enable = true;
    initExtra = ''
      export PS1="\[\033[1;34m\][\w]\[\033[0m\] "
    '';
    shellAliases = {
      rebuild = "doas nixos-rebuild switch";
      v = "vim";
      larp = "fastfetch";
      conf = "doas vim /etc/nixos/configuration.nix";
      home = "doas vim /etc/nixos/home.nix";
      snake = "python3 ";
      revive = "doas nix-channel --update";
    };
  };

  home.file.".xinitrc".text = ''
    export ADW_DISABLE_PORTAL=1
    export XCURSOR_SIZE=16

    xidlehook \
      --not-when-audio \
      --timer 300 "notify-send '[the screen will turn off in 10 seconds]'" "" \
      --timer 10 "betterlockscreen -l" "" &

    xset led named "Scroll Lock" &
    xset r rate 200 65 &

    xrandr --output HDMI-2 --mode 1600x900 --rate 75.00 &
    xwallpaper --zoom ~/wallpaper/wallpaper.jpg &

    picom &
    slstatus &
  '';

  home.file.".vimrc".text = ''
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'

call plug#end()

let g:airline_theme='catppuccin_macchiato'

syntax on
set clipboard=unnamedplus
set number relativenumber
set mouse=a
set encoding=utf-8
set noswapfile
set nobackup

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

set hlsearch
set incsearch
set ignorecase
set smartcase
set scrolloff=8

set showmode
set wildmenu

let mapleader = " "

nnoremap <leader>c :nohlsearch<CR>
nnoremap <leader>w :w<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
  '';

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        font = "Terminess Nerd Font 10";
        frame_color = "#89b4fa";
      };

      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 10;
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 10;
      };

      urgency_critical = {
        background = "#f38ba8";
        foreground = "#11111b";
        timeout = 0;
      };
    };
  };

  home.packages = with pkgs; [
    dunst
    papirus-icon-theme
    adw-gtk3
    picom
    rofi
    fastfetch
  ];

  programs.home-manager.enable = true;
}
