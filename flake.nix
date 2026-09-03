{
  description = "Alidade";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (self: super: {
          kibotPackages = {
            kiauto = super.callPackage ./nix/kiauto.nix { };
            kibot = super.callPackage ./nix/kibot.nix { };
            kidiff = super.callPackage ./nix/kidiff.nix { };
            kicost = super.callPackage ./nix/kicost.nix { };
            kikit = super.callPackage ./nix/kikit.nix { };
          };
          mkdocs-fetch-files-plugin = super.callPackage ./nix/mkdocs-fetch-files { };
        })
      ];
    };
  in {
    packages.pkgs = pkgs;
    packages.hw = pkgs.callPackage ./hw { };
    packages.docs = pkgs.callPackage ./docs { alidade-hw = self.packages.${system}.hw; };
  });
}
