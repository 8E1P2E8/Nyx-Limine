{ config, pkgs, inputs, ... }:
{
  home.username = "EPE";
  home.homeDirectory = "/home/EPE";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "router" = {
        hostname = "10.0.0.1";
        user = "root";
        identityFile = "~/.ssh/id_router";
      };
    };
  };

  imports = [
    ../../modules/nu-config.nix 
  ];
}
