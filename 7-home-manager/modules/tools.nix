{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chromium
    llm
    aichat
    mods
    fzf
    bottom
    parallel-disk-usage
    nix-tree
    tre-command
    numbat
    syft
    sops
    age
    fastfetch
    countryfetch
    sl
    tarts
    charasay
    genact
    lavat
    clock-rs
    wayland-bongocat
    catclock
    chawan
    mpv
    gh
    git
  ];
}
