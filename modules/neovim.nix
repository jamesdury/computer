{ config, pkgs, ... }:
let

  kickstart-nvim = pkgs.fetchFromGitHub {
    owner = "nvim-lua";
    repo = "kickstart.nvim";
    rev = "master"; # You can specify a specific commit hash for 
    sha256 = "sha256-h2apbeWuQhPqyy/pwu5TWtfvCWK2tYqSmcdy68rRD0g=";
  };

in
{

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home-manager.users.ceephax = {
    xdg = {
      configFile = {
        # Copy entire kickstart.nvim directory structure to nvim config
        "nvim" = {
          source = kickstart-nvim;
          recursive = true; # This ensures all subdirectories are copied
        };
      };
    };
  };
}
