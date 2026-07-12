# Web Browsers Module
# Chrome, LibreWolf, and lightweight alternatives

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Main browsers
    google-chrome # Unfree - Keep as requested
    # #     librewolf              # MPL-2.0
    chromium # BSD-3 - Open source Chrome base

    # Lightweight browsers (permissive licenses)
    surfraw # Public Domain - Command line web search
  ];
}
