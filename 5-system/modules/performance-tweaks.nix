# Performance optimizations
_:

{
  # zRAM (Compression for smoother memory usage)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 40; # Buffers video frames in compressed RAM
  };
}
