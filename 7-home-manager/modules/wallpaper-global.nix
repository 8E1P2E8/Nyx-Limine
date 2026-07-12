{ pkgs, ... }:

let
  multicsImage =
    pkgs.runCommand "Multics-Wallpaper.png"
      {
        nativeBuildInputs = [
          pkgs.imagemagick
          pkgs.freefont_ttf
        ];
      }
      ''
        magick -size 1920x1080 xc:black \
          -fill none -stroke red -strokewidth 3 \
          -font "${pkgs.freefont_ttf}/share/fonts/truetype/FreeSerif.ttf" \
          -gravity center -pointsize 800 -draw "text 0,0 'Ω'" \
          -draw "translate 960,540 scale 2,2 path 'M 0,25.5 L -15.0,-20.6 L 24.3,7.9 L -24.3,7.9 L 15.0,-20.6 Z'" \
          -draw "translate 960,540 circle 0,0 20,0 line -6,0 6,0" \
          -pointsize 1 -draw "text 0,0 'Ἐδραείν'" \
          $out
      '';
in
{
  home.file."Pictures/Wallpapers/Multics-Wallpepper.png".source = multicsImage;
}
