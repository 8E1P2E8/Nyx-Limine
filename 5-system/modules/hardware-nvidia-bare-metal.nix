# NVIDIA GTX 1080 (Pascal) - Bare Metal Configuration
{ config, ... }:

{
  # Enable OpenGL with 32-bit support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # NVIDIA driver configuration for GTX 1080
  hardware.nvidia = {
    modesetting.enable = true; # Required for Wayland
    open = false; # Proprietary for Pascal
    nvidiaSettings = true; # Enable nvidia-settings
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    forceFullCompositionPipeline = true; # Fix screen tearing
  };

  # Kernel modules and parameters
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Essential environment variables (replaces performance.nix)
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm"; # NVIDIA DRM backend
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # NVIDIA OpenGL
    LIBVA_DRIVER_NAME = "nvidia"; # Video acceleration
    __GL_THREADED_OPTIMIZATIONS = "1"; # Basic OpenGL optimization
  };
}
