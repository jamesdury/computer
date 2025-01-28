{ pkgs, home-manager, ... }:
let
  kickstart = import (builtins.fetchGit {
    url = "https://github.com/nvim-lua/kickstart.nvim";
    #    rev = "main"; # You can specify a particular branch or commit here
  });

in {

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ceephax = {
      home = {
        stateVersion = "23.11";

        packages = with pkgs; [ neovim ];

      };
      xdg = { enable = true; };

      #sessionVariables = {
      #    # session.
      #    XDG_CURRENT_DESKTOP = "sway";
      #    XDG_SESSION_DESKTOP = "sway";
      #    XDG_SESSION_TYPE = "wayland";

      #    # wayland stuff.
      #    MOZ_ENABLE_WAYLAND = "1";
      #    MOZ_USE_XINPUT2 = "1";
      #    QT_QPA_PLATFORM="wayland";
      #    QT_WAYLAND_DISABLE_WINDOWDECORATION="1";
      #    SDL_VIDEODRIVER = "wayland";

      #    # apps stuff.
      #    _JAVA_AWT_WM_NONREPARENTING=1;

      #};

      #xdg.configFile."sway/config".source = ''
      #  output * resolution 1920x1080
      #'';

    };
  };
}
