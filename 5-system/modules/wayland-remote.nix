{ config, lib, pkgs, ... }:
let
  cfg = config.services.wayland-remote;
in
{
  options.services.wayland-remote = {
    enable = lib.mkEnableOption "High-Performance Remote Wayland";
    user = lib.mkOption {
      type = lib.types.str;
      default = config.var.mainUser or "omen";
    };
    resolution = lib.mkOption {
      type = lib.types.str;
      default = "1920x1080";
    };
    fps = lib.mkOption {
      type = lib.types.int;
      default = 60;
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 5900 ];
    services.seatd.enable = true;

    environment.etc."pam.d/wayvnc".text = ''
      account required ${pkgs.linux-pam}/lib/security/pam_unix.so
      auth sufficient ${pkgs.linux-pam}/lib/security/pam_unix.so likeauth nullok try_first_pass
      auth required ${pkgs.linux-pam}/lib/security/pam_deny.so
      password sufficient ${pkgs.linux-pam}/lib/security/pam_unix.so nullok yescrypt
      session required ${pkgs.linux-pam}/lib/security/pam_env.so conffile=/etc/pam/environment readenv=0
      session required ${pkgs.linux-pam}/lib/security/pam_unix.so
      session required ${pkgs.linux-pam}/lib/security/pam_loginuid.so
      session optional ${pkgs.systemd}/lib/security/pam_systemd.so
      session required ${pkgs.linux-pam}/lib/security/pam_limits.so
    '';

    systemd.services.wayvnc = {
      description = "GPU-Accelerated Headless Sway and WayVNC ${cfg.resolution}";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" "seatd.service" ];

      environment = {
        XDG_RUNTIME_DIR = "/run/user/1000";
        WLR_BACKENDS = "headless";
        XDG_SESSION_TYPE = "wayland";
        WAYLAND_DISPLAY = "wayland-9";
        WLR_HEADLESS_OUTPUTS = "1";
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        EGL_PLATFORM = "wayland";
        WLR_RENDERER = "pixman";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
      };

      serviceConfig = {
        User = cfg.user;
        PAMName = "wayvnc";
        Type = "simple";
        SupplementaryGroups = [ "video" "render" "seat" ];
        ExecStart = pkgs.writeShellScript "start-remote-sway" ''
          set -e
          pkill -u ${cfg.user} wayvnc || true
          pkill -u ${cfg.user} sway || true
          rm -f $XDG_RUNTIME_DIR/wayland-9*
          rm -f $XDG_RUNTIME_DIR/wayvncctl*

          cat << "S_EOF" > /tmp/sway-headless.conf
          output HEADLESS-1 resolution ${cfg.resolution}@${toString cfg.fps}Hz
          include /etc/sway/config
          exec ${pkgs.wayvnc}/bin/wayvnc -g --max-fps ${toString cfg.fps} 0.0.0.0 5900 > /tmp/wayvnc.log 2>&1 &
          S_EOF

          exec ${pkgs.dbus}/bin/dbus-run-session \
            ${pkgs.sway}/bin/sway \
            --unsupported-gpu \
            -c /tmp/sway-headless.conf > /tmp/sway.log 2>&1
        '';
        Restart = "always";
        RestartSec = "3";
      };
    };
  };
}
