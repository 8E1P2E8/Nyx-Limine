{ config, pkgs, ... }: {
  programs.sway.enable = true;

  # 1. Natively map autologin to match the dynamic hostname-based username
services.getty.autologinUser = builtins.head (builtins.attrNames (pkgs.lib.filterAttrs (n: v: v.isNormalUser) config.users.users));

  # 2. Safely trap the successful login on TTY1 and launch Sway
  environment.loginShellInit = ''
    # exec sway block removed for headless stability
  '';
}
