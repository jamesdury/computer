# modules/docker.nix
{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.docker = {
    enable = true;
    # Optional: enable nvidia-docker support
    # enableNvidia = true;
  };

  # Add any users that need docker access to the docker group
  users.users.ceephax.extraGroups = [ "docker" ];

  # Install docker related packages
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
