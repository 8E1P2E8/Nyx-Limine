# Productivity Tools Module
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # notion-app-enhanced    # Unfree - commented out
    joplin # AGPL-3.0+
  ];
}
