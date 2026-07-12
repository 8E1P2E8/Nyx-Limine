{ inputs, pkgs, ... }:
{
  imports = [
    (inputs.self + "/6-users/humans/EPE.nix")
  ];

  # Universal Home Manager injection across all system profiles
  home-manager.sharedModules = [
    (inputs.self + "/7-home-manager/modules/tools.nix")
  ];

  # Shared Core System Adjustments
  hardware.nvidia.modesetting.enable = true;

  # Shared Swap Management
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4096;
    }
  ];

  nix.settings.require-sigs = false;
  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}
