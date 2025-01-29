{
  config,
  lib,
  pkgs,
  ...
}:
{

  security.polkit.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  #home-manager = {
  #  users = {
  #    ceephax = {
  #      xdg = {
  #        configFile."sway/config".source = ../config/sway/config;
  #      };
  #    };
  #  };
  #};
}
