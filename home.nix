{ pkgs, ... }:

{
  home.username = "ravyc";
  home.homeDirectory = "/home/ravyc";
  home.stateVersion = "26.05";

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home.file.".config/gtk-4.0/gtk.css".text = ''
    @define-color accent_color #89b4fa;
    @define-color accent_bg_color #89b4fa;
    @define-color window_bg_color #1e1e2e;
    @define-color window_fg_color #cdd6f4;
    @define-color view_bg_color #181825;
    @define-color view_fg_color #cdd6f4;
    @define-color headerbar_bg_color #11111b;
    @define-color headerbar_fg_color #cdd6f4;
    @define-color card_bg_color #1e1e2e;
    @define-color card_fg_color #cdd6f4;
    @define-color dialog_bg_color #1e1e2e;
    @define-color dialog_fg_color #cdd6f4;
    @define-color popover_bg_color #1e1e2e;
    @define-color popover_fg_color #cdd6f4;
  '';

  home.file.".config/gtk-3.0/gtk.css".text = ''
    @define-color accent_color #89b4fa;
    @define-color accent_bg_color #89b4fa;
    @define-color window_bg_color #1e1e2e;
    @define-color window_fg_color #cdd6f4;
    @define-color view_bg_color #181825;
    @define-color view_fg_color #cdd6f4;
    @define-color headerbar_bg_color #11111b;
    @define-color headerbar_fg_color #cdd6f4;
  '';

  home.pointerCursor = {
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

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
    export GTK_THEME="adw-gtk3-dark"
    export ADW_DISABLE_PORTAL=1
    export XCURSOR_THEME="Catppuccin-Mocha-Dark-Cursors"
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
  ];

  programs.home-manager.enable = true;
}  
