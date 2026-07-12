# Common host configuration module
# Import this in each host to get standard system configuration
# Reduces boilerplate in hosts/<name>/configuration.nix

{ inputs, ... }:

{
  imports = [
    # Essential system modules - always imported
    inputs.self.nixosModules.login-manager
    # Bootloader is now configured via theme-bootloader in host config
    inputs.self.nixosModules.locale-timezone
    inputs.self.nixosModules.network
    inputs.self.nixosModules.audio-pipewire
    inputs.self.nixosModules.ssh-server
    inputs.self.nixosModules.nix-settings
    # # # # # inputs.self.nixosModules.user-omen
    # NEW: Custom theme engine (replaces Stylix)
    # Note: theme-engine and theme-bootloader are now imported in host config
  ];
}
