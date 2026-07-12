{ pkgs, lib, config, ... }:

{
  # Force-evaluated user profile configuration v2
  imports = [
    ../../5-system/modules/terminal-foot.nix
    ../../5-system/modules/nu-banner.nix
    ../../5-system/modules/swayw.nix
  ];

  # Non-systemd Networking & Host Settings (Merged from network-ssh.nix)
  networking.hostName = "latitude5400"; 
  time.timeZone = "America/Los_Angeles";
  services.dhcpcd.enable = true;
  services.iwd.enable = true;
  services.openssh = { enable = true; settings.PermitRootLogin = "no"; };

  # Graphical & Desktop Settings
  programs.labwc.enable = true;
  programs.sway.enable = true;
  services.mdevd.enable = true;
  services.seatd.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      initial_session = { command = "sway"; user = "EPE"; };
      default_session = { command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway"; user = "greeter"; };
    };
  };
  fonts = { 
    fontconfig.enable = true; 
    enableDefaultPackages = true; 
    packages = with pkgs; [ nerd-fonts.fira-code ]; 
  };

  # Merged System Packages from user-apps.nix
  environment.systemPackages = with pkgs; [ 
    vim 
    wget 
    git 
    nixos-rebuild-ng 
    iputils 
    iproute2 
    foot 
    crosvm 
    chromium 
    gh 
  ];

  # User Configuration
  users.users.EPE = {
    isNormalUser = true;
    description = lib.mkForce "EPE User Account";
    password = "$y$j9T$ger6rFJk9H.iujdy2aPGc1$UmV.PRDaSg.zBXUFqsUFOZDqO8XraS.rNXHXVehDLq5";
    shell = pkgs.bash; 
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "video" 
      "audio" 
      "kvm" 
      (config.services.seatd.group or "seatd")
    ];
  };

  # Greeter configuration from user-apps.nix
  users.users.greeter = { 
    extraGroups = [ 
      "video" 
      (config.services.seatd.group or "seatd") 
    ]; 
  };
}
