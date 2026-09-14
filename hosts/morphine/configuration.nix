{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../pkgs/default.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  
  boot.kernelParams = [
    "intel_pstate=active"
    "i915.enable_guc=3"
    "i915.enable_fbc=1"
    "i915.fastboot=1"
    "mitigations=off"
    "nowatchdog"
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "kernel.nmi_watchdog" = 0;
    "kernel.unprivileged_userns_clone" = 1;
  };

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

  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = true;
  services.irqbalance.enable = true;
  services.fstrim.enable = true;

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
      package = pkgs.myDwm;
    };
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      bigclock = false;
      header_checksum = false;
      hide_borders = false;
      bg = 0;
      fg = 7;
      border_fg = 7;
      active_border_fg = 7;
    };
  };

  services.displayManager.defaultSession = "none+dwm";

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      vulkan-loader
      inteltool
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
  programs.nix-ld.enable = true;

  home-manager.backupFileExtension = "backup"; 
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
    mySt
    mySlstatus
    python3
    uv
    sqlite
    nodejs
    picom
    xwallpaper
    xidlehook
    betterlockscreen
    libnotify
    usbutils
    appimage-run
    steam-run
    ppsspp
    pcsx2
    fastfetch
    vim-full
    git
    wget
    gnumake
    gcc
    pkg-config
    unzip
    glib
    mpv
    lxappearance
    catppuccin-gtk
    firefox
    pavucontrol
    thunar
    obs-studio
    rofi
    maim
    slop
    xclip    
    xinit
    xrandr
    dunst
  ];

  system.stateVersion = "26.05";
}
