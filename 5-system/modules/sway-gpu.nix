# Sway configuration with unsupported GPU support
_:

{
  # Force Sway to support "Unsupported" GPU (NVIDIA)
  programs.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
  };
}
