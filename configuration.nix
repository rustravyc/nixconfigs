{ config, pkgs, ... }:

let
  myDwm = pkgs.dwm.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "rustravyc";
      repo = "dwm";
      rev = "main";
      hash = "sha256-sjiwiukygyrgnTDorpIf2+yJjhSJdWp71BYKeT/ZLQs=";
    };
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ (with pkgs; [ pkg-config gnumake gcc ]);
    buildInputs = (oldAttrs.buildInputs or [ ]) ++ (with pkgs; [ libx11 libxinerama libxft fontconfig ]);
    preBuild = "make clean";
    makeFlags = [ "PREFIX=$(out)" ];
  });

  mySt = pkgs.st.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "rustravyc";
      repo = "st";
      rev = "main";
      hash = "sha256-+qTOMIVkjoL05nzjxUFPocRkMknpr3BJ/PQuHwkmlpw=";
    };
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ (with pkgs; [ pkg-config gnumake gcc ncurses ]);
    buildInputs = (oldAttrs.buildInputs or [ ]) ++ (with pkgs; [ libx11 libxft fontconfig ]);
    preBuild = "make clean";
    makeFlags = [ "PREFIX=$(out)" ];
  });

  mySlstatus = pkgs.slstatus.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "rustravyc";
      repo = "slstatus";
      rev = "main";
      hash = "sha256-IMyqSABzo6AxWX1DQGx2QOEi78L0H8qV4E2ImDZ8PQ8=";
    };
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ (with pkgs; [ pkg-config gnumake gcc ]);
    buildInputs = (oldAttrs.buildInputs or [ ]) ++ (with pkgs; [ libx11 ]);
    preBuild = "make clean";
    makeFlags = [ "PREFIX=$(out)" ];
  });
in
{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  home-manager.users.ravyc = import ./home.nix;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "morphine";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "pt_BR.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.terminess-ttf
    ];
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "br";
      variant = "abnt2";
    };

    videoDrivers = [ "modesetting" ];

    deviceSection = ''
      Option "TearFree" "true"
    '';

    displayManager.sessionCommands = ''
      if [ -f "$HOME/.xinitrc" ]; then
        . "$HOME/.xinitrc"
      fi
    '';

    windowManager.dwm = {
      enable = true;
      package = myDwm;
    };
  };

  services.displayManager.ly.enable = true;
  services.displayManager.defaultSession = "none+dwm";

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.ravyc = {
    isNormalUser = true;
    description = "ravyc";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" ];
    packages = with pkgs; [ ];
  };

  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "ravyc" ];
      keepEnv = true;
      persist = true;
    }];
  };

  nixpkgs.config.allowUnfree = true;
  
  programs.i3lock.enable = true;	
  security.pam.services.i3lock = {};
  security.pam.services.betterlockscreen = {};
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    myDwm
    mySt
    mySlstatus

    python315

    picom
    xwallpaper
    xidlehook
    betterlockscreen
    libnotify

    fastfetch
    vim-full
    git
    wget
    gnumake
    gcc
    pkg-config
    unzip
    glib
    lxappearance
    arandr

    catppuccin-gtk

    discord
    ppsspp
    pcsx2
    steam
    lutris
    protonplus
    protontricks
    
    vlc
    obs-studio
    firefox
    pavucontrol
    thunar
    rofi
    maim
    slop
    xclip	
    xinit
    xrandr
    dunst
    appimage-run
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  programs.nix-ld = {
    enable = true;
      };
  
  home-manager.backupFileExtension = "backup"; 
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  system.stateVersion = "26.05";
}
