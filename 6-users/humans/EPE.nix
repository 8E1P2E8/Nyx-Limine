{ pkgs, lib, config, ... }:

{
  # Force-evaluated user profile configuration v2
  imports = [
    ../../5-system/modules/terminal-foot.nix
    ../../5-system/modules/nu-banner.nix
  ];

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
}
