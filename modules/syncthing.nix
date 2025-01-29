# modules/syncthing.nix
{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.syncthing = {
    enable = true;
    user = "ceephax";
    dataDir = "/home/ceephax"; # This will create a Syncthing folder in your home directory
    configDir = "/home/ceephax/.config/syncthing";

    # Open firewall ports for Syncthing
    openDefaultPorts = true;

    # Enable GUI access
    guiAddress = "127.0.0.1:8384"; # Local access only by default

    # Optionally enable systemd integration
    systemService = true;
  };

  # Add syncthing to system packages
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  # Allow Syncthing through the firewall
  networking.firewall = {
    allowedTCPPorts = [
      8384
      22000
    ]; # GUI and transfer ports
    allowedUDPPorts = [
      22000
      21027
    ]; # Transfer and discovery ports
  };
}
