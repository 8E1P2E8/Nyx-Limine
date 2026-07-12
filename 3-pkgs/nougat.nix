{ stdenv, lib, tesseract, bash, ... }:

stdenv.mkDerivation {
  pname = "math-ocr";
  version = "0.1.0";

  # Points to local directory to populate the .src attribute
  src = ./.;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cat << 'EOF2' > $out/bin/math-ocr
    #!${bash}/bin/bash
    set -e

    if [ $# -eq 0 ]; then
      echo "Usage: math-ocr <image.png>"
      exit 1
    fi

    # Explicitly call tesseract directly from the Nix store
    ${tesseract}/bin/tesseract "$1" stdout 2>/dev/null
    EOF2

    chmod +x $out/bin/math-ocr
  '';

  meta = with lib; {
    description = "Simple declarative math OCR using tesseract with equation mode";
    mainProgram = "math-ocr";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
