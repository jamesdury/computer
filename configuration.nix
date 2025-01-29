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
      lib
      ;
  }) ./modules;

  environment.systemPackages =
    with pkgs;
    [
      neovim
      fd
      firefox
      git
      ripgrep
      zig
      pkgs.xdg-user-dirs
      sunshine
    ]
    ++ (with nixpkgs-unstable.legacyPackages.${pkgs.system}; [ ghostty ]);

  users.users.ceephax = {
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    home = "/home/ceephax";
    group = "users";
    uid = 1000;
    password = "password";

    packages = [ pkgs.xdg-user-dirs ];
  };

  security.sudo.enable = true;
  # change me
  users.users.root.initialPassword = "nixos";

  #  networking.hostName = lib.mkDefault config.networking.hostName;

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.registry.nixpkgs.flake = nixpkgs;
}
