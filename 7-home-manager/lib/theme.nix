# Sledgehammer Red/Black Theme

rec {
  slug = "red-black";
  name = "Red/Black";
  author = "Nyx";
  description = "High-contrast red/black sledgehammer theme";

  # Base16 colors with core palette nested
  colors = rec {
    black = "000000";
    red = {
      dark = "330000";
      medium = "800000";
      bright = "ff0000";
      pink = "ff0046";
    };
    base00 = black;
    base01 = red.dark;
    base02 = red.medium;
    base03 = red.dark;
    base04 = red.medium;
    base05 = red.bright;
    base06 = red.bright;
    base07 = red.bright;
    base08 = red.bright;
    base09 = red.bright;
    base0A = red.pink;
    base0B = red.dark;
    base0C = red.medium;
    base0D = red.bright;
    base0E = red.bright;
    base0F = red.bright;
  };

  # Semantic aliases
  semantic = with colors; rec {
    background = "#${black}";
    surface = "#${red.dark}";
    primary = "#${red.bright}";
    accent = "#${red.pink}";
  };

  # App configs
  apps = with semantic; {
    librewolf = {
      windowBg = background;
      tabBarBg = background;
      activeTabBg = primary;
      activeTabText = background;
      inactiveTabText = primary;
      urlBarBg = surface;
      urlBarText = primary;
      urlBarFocusBg = surface;
      sidebarBg = background;
      sidebarText = primary;
      popupBg = background;
      popupText = primary;
      popupBorder = primary;
      borderColor = primary;
    };
    terminal = {
      inherit background;
      foreground = primary;
      cursor = primary;
      selectionBg = surface;
      selectionFg = primary;
    };
    bootloader = {
      backgroundColor = background;
    };
  };
}
