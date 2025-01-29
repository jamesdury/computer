{
  config,
  lib,
  pkgs,
  ...
}:
{

  environment.sessionVariables = {
    # XDG Base Directories
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.config/cache";
    XDG_RUNTIME_DIR = "/run/user/$UID";

    # XDG User Directories
    XDG_DESKTOP_DIR = "$HOME/Desktop";
    XDG_DOCUMENTS_DIR = "$HOME/Documents";
    XDG_DOWNLOAD_DIR = "$HOME/Downloads";
    XDG_MUSIC_DIR = "$HOME/Music";
    XDG_PICTURES_DIR = "$HOME/Pictures";
    XDG_PUBLICSHARE_DIR = "$HOME/Public";
    XDG_TEMPLATES_DIR = "$HOME/Templates";
    XDG_VIDEOS_DIR = "$HOME/Videos";

    # System and Wayland Configuration
    XKB_DEFAULT_OPTIONS = "caps:escape";
    GDK_BACKEND = "wayland";
    XCURSOR_THEME = "Adwaita";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  systemd.user.services.xdg-user-dirs = {
    description = "XDG User Directories Initialization";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update";
      RemainAfterExit = true;
    };
  };
}
