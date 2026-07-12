# System Administration & Monitoring Module
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    k9s # Apache-2.0
    jq # MIT
    fzf # MIT
    nix-tree # MIT
    parallel-disk-usage # MIT
    aichat # MIT
  ];
}
