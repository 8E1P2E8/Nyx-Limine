# Terminal Fun & System Info Module
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    genact # MIT
    tarts # MIT
    charasay # MIT
    clock-rs # MIT
    lavat # MIT
    zigfetch # MIT
    neo-cowsay # GPL-3 # alt figlet # AFL-2.1 nixpkgs
    fortune # BSD-3-Clause
    tre-command # MIT
    sl # Custom
  ];
}
