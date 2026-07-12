{ ... }:
{
  programs.nushell = {
    enable = true;
    extraConfig = ''
      # 1. Capture the absolute start time immediately
      let manual_start = (date now)

      $env.config.show_banner = false

      # 2. Calculate the difference at this point
      if ($env | get -o INITIALIZED | is-empty) {
          let delta = ((date now) - $manual_start)
          print ($delta | into string)
          $env.INITIALIZED = true
      }
    '';
  };
}
