{ pkgs, ... }:

let
  footConfig = pkgs.writeText "foot.ini" ''
    [main]
    font=monospace:size=11
    pad=8x8
    term=foot
    shell=${pkgs.nushell}/bin/nu

    [colors-dark]
    foreground=ff0000
    background=000000
    cursor=ff0000 ff0000
    selection-foreground=ffffff
    selection-background=ff0000

    [key-bindings]
    pipe-scrollback=[sh -c "wl-copy"] Control+Shift+a
  '';
in
{
  # Add nushell to the system's valid shells listing (/etc/shells)
  environment.shells = [ pkgs.nushell ];

  # Install packages system-wide across all machines
  environment.systemPackages = [
    pkgs.foot
    pkgs.nushell
  ];

  environment.etc."xdg/foot/foot.ini".source = footConfig;

  # Expose global environmental variables
  environment.variables = {
    swayTerm = "foot";
    SHELL = "${pkgs.nushell}/bin/nu";
  };
}
