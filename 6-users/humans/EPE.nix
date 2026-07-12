{ pkgs, lib, ... }:

{
  # Define the user account
  users.users.EPE = {
    isNormalUser = true;
    description = lib.mkForce "EPE User Account";
    extraGroups = [ 
      "wheel"           # Allows sudo privileges
      "networkmanager"  # Allows network configuration changes
      "video"           # Screen brightness / hardware acceleration controls
      "audio"           # Audio control
    ];
    
    # Define default user shell
    shell = pkgs.bash; 
  };
}
