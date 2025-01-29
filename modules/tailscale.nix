# modules/tailscale.nix
{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.tailscale = {
    enable = true;
    permitCertUid = "tailscale";
    useRoutingFeatures = "both";
  };

  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      checkReversePath = "loose";
    };

    nat = {
      enable = true;
      enableIPv6 = true;
    };
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];
}
