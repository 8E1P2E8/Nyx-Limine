{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    # Centralized global flake modules
    inputs.self.nixosModules.host-common
    inputs.self.nixosModules.login-manager
    inputs.self.nixosModules.terminal-foot
    inputs.self.nixosModules.bootloader-systemd
    inputs.self.nixosModules.network
    inputs.self.nixosModules.audio-pipewire
    inputs.self.nixosModules.android-access
    inputs.self.nixosModules.latitude-common

    # Redirected to the new 4-hardware architectural block
    ../../4-hardware/x86_64-linux/latitude/hardware-configuration.nix
    (inputs.self + "/3-pkgs/packs.nix")
  ];

  networking.hostName = "latitude";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";
}
