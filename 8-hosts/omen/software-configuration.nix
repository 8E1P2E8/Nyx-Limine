{ inputs, ... }: {
  imports = [
    # Redirected to the new 4-hardware architectural block
    ../../4-hardware/x86_64-linux/omen/hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager

    # Shared Profiles (Base Nodes)
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.self.nixosModules.host-common
    inputs.self.nixosModules.bootloader-systemd
    inputs.self.nixosModules.terminal-foot
    
    # Feature Toggles
    inputs.self.nixosModules.wayland-remote
    inputs.self.nixosModules.sway-gpu
    inputs.self.nixosModules.swayw
    inputs.self.nixosModules.boot-nvidia
    inputs.self.nixosModules.performance-tweaks
    inputs.self.nixosModules.android-access
    inputs.self.nixosModules.bluetooth
  ];

  networking.hostName = "omen";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";

  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;

  services.wayland-remote = {
    enable = true;
    resolution = "1920x1080";
    fps = 60;
  };

  # Pure declarative directory mirror layout
  fileSystems."/home/EPE" = {
    device = "/home/omen";
    fsType = "none";
    options = [ "bind" ];
  };

  # Keep both users mapped with identical permissions
  users.users.omen = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "video" "users" ];
  };

  users.users.EPE = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "wheel" "networkmanager" "video" "users" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDT+/kH7IJOVqYUbCREeAF/xi7Sd814onkydZOA+6tAx latitude5400@latitude5400"
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.omen = import ./users/omen.nix;
    # EPE safely inherits omen's active generation view through the filesystem bind-mount
  };
}
