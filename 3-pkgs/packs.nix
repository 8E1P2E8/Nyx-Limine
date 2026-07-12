{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- File Management & Core Utilities ---
    pcmanfm # License: GPL-2.0-or-later       [CL - Copyleft]
    dragon-drop # License: GPL-3.0-or-later       [CL - Copyleft]
    unzip # License: Info-ZIP               [CF - Copyfree]

    comma
    nix-index # Required backend for comma to find matching binaries

    # Essential power-user community utilities
    nh # Clean, modern CLI wrapper for nixos-rebuild
    nvd # Package diff tool (shows exactly what changed on every switch)
    ripgrep # Blazing fast grep replacement
    fd # User-friendly alternative to find
    fzf # Fuzzy finder for your shell
    gh
    ssh-to-age

    # --- Sway Window Manager & Desktop Environment ---
    sway # License: MIT                    [CF - Copyfree]
    swaybg # License: MIT                    [CF - Copyfree]
    swaylock # License: MIT                    [CF - Copyfree]
    swayidle # License: MIT                    [CF - Copyfree]
    wmenu # License: MIT                    [CF - Copyfree]
    grim # License: MIT                    [CF - Copyfree]
    slurp # License: MIT                    [CF - Copyfree]
    wl-clipboard # License: GPL-3.0-or-later       [CL - Copyleft]
    wf-recorder # License: MIT                    [CF - Copyfree]

    # --- Development Tools & Compilers ---
    zed-editor # License: GPL-3.0-only           [CL - Copyleft]
    hello-go # License: MIT                    [CF - Copyfree]
    python3 # License: PSF-2.0                [CF - Copyfree]
    zig # License: MIT                    [CF - Copyfree]
    go # License: BSD-3-Clause           [CF - Copyfree]
    rustc # License: MIT/Apache-2.0         [CF - Copyfree]
    cargo # License: MIT/Apache-2.0         [CF - Copyfree]
    llvmPackages.llvm # License: Apache-2.0 w/ LLVM Exc [CF - Copyfree]
    llvmPackages.clang # License: Apache-2.0 w/ LLVM Exc [CF - Copyfree]
    fossil # License: BSD-2-Clause           [CF - Copyfree]
    antigravity # Pure physics layout

    # --- Media, Graphics & Apps ---
    pixelorama # License: MIT                    [CF - Copyfree]
    imagemagick # License: ImageMagick (Perm)     [CF - Copyfree]
    zoom-us # License: Proprietary             [CR - Copyright]
    lynx # License: GPL-2.0-only           [CL - Copyleft]

    # --- Networking, Virtualization & Sysadmin ---
    qemu # License: GPL-2.0-only           [CL - Copyleft]
    tcpdump # License: BSD-3-Clause           [CF - Copyfree]
    tftp-hpa # License: BSD-3-Clause           [CF - Copyfree]
    tesseract # License: Apache-2.0             [CF - Copyfree]
  ];
}
