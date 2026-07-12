# System Terminal & Shell Module
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    xonsh # BSD-2-Clause
    uutils-coreutils-noprefix # MIT
    uutils-findutils # MIT
    uutils-diffutils # MIT
  ];
}
