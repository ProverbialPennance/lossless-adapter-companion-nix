{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-$LATEST_STABLE";
    };
  };
  outputs = {nixpkgs, ...}: let
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in rec {
      lossless-adapter-companion = pkgs.callPackage ./companion {};
      default = lossless-adapter-companion;
    });
  };
}
