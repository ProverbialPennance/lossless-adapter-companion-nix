{pkgs ? import <nixpkgs> {}, ...}: let
  inherit (pkgs) buildFHSEnv;
in
  buildFHSEnv {
    name = "lossless-adapter-companion";
    targetPkgs = p:
      with p; [
        icu.dev
        libgcc.lib
        zlib.out
        xorg.libICE
        xorg.libSM
        xorg.libX11
        libGL
        skia
        fontconfig
        libusb1
        openssl

        curlFull
        gzip
      ];
    runScript = builtins.readFile ./run_latest.sh;
  }
