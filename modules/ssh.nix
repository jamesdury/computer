{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  users.users.ceephax = {
    openssh.authorizedKeys.keyFiles = [
      (pkgs.fetchurl {
        url = "https://github.com/jamesdury.keys";
        sha256 = "sha256-waeSFPWOOt6EQ4KCBi1hbN2xRi8FFcJ0Hv7x5/j58Xo="; 
      })
    ];
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
}
