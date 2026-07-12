# Boot configuration for NVIDIA GPU
_:

{
  # Blacklist nouveau to ensure proprietary NVIDIA loads
  boot.blacklistedKernelModules = [ "nouveau" ];
}
