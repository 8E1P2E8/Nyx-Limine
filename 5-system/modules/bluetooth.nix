# Bluetooth module with bluetuith (MIT License)
{ pkgs, ... }:
{
  hardware.bluetooth.enable = false;
  environment.systemPackages = [ pkgs.bluetuith ];
}
