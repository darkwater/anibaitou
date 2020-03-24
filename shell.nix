let
  onyx = import (builtins.fetchTarball https://github.com/darkwater/onyx/archive/master.tar.gz) {};
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> {
    overlays = [ onyx.overlay moz_overlay ];
    config = {
      android_sdk.accept_license = true;
    };
  };
in
  with nixpkgs;
  stdenv.mkDerivation {
    name = "anibaitou";
    buildInputs = [
      nixpkgs.nodePackages.cordova
      nixpkgs.nodePackages.node2nix
      nixpkgs.nodePackages.wasm2js

      cargo-web
      gradle
      jdk
      nodejs

      ((rustChannelOf { date = "2020-03-19"; channel = "nightly"; }).rust.override {
        targets = [
          "wasm32-unknown-unknown"
        ];
      })

      (androidenv.composeAndroidPackages {
        platformVersions = [ "28" ];
      }).androidsdk

      (writeScriptBin "patch-aapt2" ''
        echo patching aapt2 locations:
        find ~/.gradle -name aapt2 -executable -type f \
          -print \
          -exec patchelf --set-interpreter ${glibc}/lib/ld-linux-x86-64.so.2 {} \;
      '')
    ];
    LD_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
      xorg.libX11
      xorg.libXcursor
    ];
  }
