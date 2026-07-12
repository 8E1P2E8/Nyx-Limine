# Gaming Module
# Steam gaming platform

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    steam # Unfree # no permissive alternative available
  ];
}
