{ config, pkgs, ... }:

let
  username = "EPE"; 
  userHome = "/home/${username}";

  # Define the Nushell configuration purely inside the Nix store
  nuConfig = pkgs.writeText "config.nu" ''
    # 1. Capture the absolute start time immediately
    let manual_start = (date now)

    $env.config.show_banner = false

    # 2. Calculate the difference at this point
    if ($env | get -o INITIALIZED | is-empty) {
        let delta = ((date now) - $manual_start)
        print ($delta | into string)
        $env.INITIALIZED = true
    }
  '';

  # Minimal default env.nu so Nushell doesn't complain about missing files
  nuEnv = pkgs.writeText "env.nu" ''
    # Minimal user env configuration
  '';
in {
  # Map script text into the finix structured activation stage
  system.activation.scripts.nushellHomeSetup = ''
    TARGET_DIR="${userHome}/.config/nushell"
    
    # Ensure the target directory exists
    mkdir -p "$TARGET_DIR"
    
    # Atomically symlink the Nix store files into the user's home
    ln -sfn "${nuConfig}" "$TARGET_DIR/config.nu"
    ln -sfn "${nuEnv}" "$TARGET_DIR/env.nu"
    
    # Explicitly fix ownership since activation runs as root
    chown -R ${username}:users "${userHome}/.config"
  '';
}
