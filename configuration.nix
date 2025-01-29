{
  config,
  lib,
  myLib,
  pkgs,
  nixpkgs,
  nixpkgs-unstable,
  ...
}:
let
  homeConfig = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ceephax = {
      home = {
        stateVersion = "23.11";
        packages = with pkgs; [ ];
      };
      xdg = {
        enable = true;
      };
    };
  };
in
{
  
  home-manager = homeConfig;

  imports = myLib.mapModules ({
    inherit
      homeConfig
      pkgs
      config
      lib;
  }) ./modules;


  users.users.ceephax = {
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    home = "/home/ceephax";
    group = "users";
    uid = 1000;
    password = "password";
  };

  security.polkit.enable = true;

  environment.systemPackages =
    with pkgs;
    [
      neovim
      fd
      firefox
      git
      ripgrep
      zig
    ]
    ++ (with nixpkgs-unstable.legacyPackages.${pkgs.system}; [ ghostty ]);

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.registry.nixpkgs.flake = nixpkgs;
}
