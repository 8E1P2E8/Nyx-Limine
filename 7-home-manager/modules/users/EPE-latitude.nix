{ inputs, ... }:
{
  home.username = "EPE";
  home.stateVersion = "25.11";

  imports = [
    ../system-security.nix
    ../tools.nix
    ../nu-config.nix
    ../wallpaper-global.nix
    ../../../5-system/modules/nu-banner.nix
  ];
}
