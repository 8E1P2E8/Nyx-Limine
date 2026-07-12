{ inputs, ... }: 
let
  theme = import (inputs.self + "/7-home-manager/lib/theme.nix");
in {
  _module.args.theme = theme;

  home = {
    username = "omen";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  imports = [
    ../../../7-home-manager/modules/nu-config.nix
    ../../../7-home-manager/modules/wallpaper-global.nix
    # Shared modules

    # Packages assigned specifically to this host's user
    (inputs.self + "/3-pkgs/browsers.nix")
    (inputs.self + "/3-pkgs/cloud.nix")
    (inputs.self + "/3-pkgs/social.nix")
    (inputs.self + "/3-pkgs/development.nix")
    (inputs.self + "/3-pkgs/gaming.nix")
    (inputs.self + "/3-pkgs/productivity.nix")
    (inputs.self + "/3-pkgs/system-administration.nix")
    (inputs.self + "/3-pkgs/system-security.nix")
    (inputs.self + "/3-pkgs/system-terminal.nix")
    (inputs.self + "/3-pkgs/terminal-fun.nix")
  ];
}
