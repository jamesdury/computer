{ config, myLib, pkgs, nixpkgs, ... }: {
  imports = myLib.mapModules ./modules;

  users.users.ceephax = {
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    home = "/home/ceephax";
    group = "users";
    uid = 1000;
    password = "password";
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [ firefox wezterm git ];

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.registry.nixpkgs.flake = nixpkgs;
}
