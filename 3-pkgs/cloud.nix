# Cloud Tools Module
# Google Cloud SDK and guest agent

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    google-cloud-sdk # Apache-2.0 # alt awscli # Apache-2.0 nixpkgs
    google-guest-agent # Apache-2.0
  ];
}
