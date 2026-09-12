{ pkgs, ... }:

{
  imports = [
    ./programs/default.nix
  ];

  home.username = "ravyc";
  home.homeDirectory = "/home/ravyc";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    dunst
    papirus-icon-theme
    picom
    rofi
    fastfetch
  ];

  programs.home-manager.enable = true;
}
