{ inputs, ... }:

{
  config = {
    system = "x86_64-linux";
    
    hosts = {
      latitude5400 = ../8-hosts/latitude5400.nix;
      latitude     = ../8-hosts/latitude.nix;
      omen         = ../8-hosts/omen.nix;
    };

    overlays = [
      (import ../2-overlays/core-stdenv.nix { inherit inputs; })
    ];
  };
}
