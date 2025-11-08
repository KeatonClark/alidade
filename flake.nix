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
        })
      ];
    };
    /*python = pkgs.python3;
    kiauto = python.pkgs.buildPythonPackage {
      pname = "kiauto";
      version = "2.3.5";
      src = pkgs.fetchPypi {
        pname = "kiauto";
        version = "2.3.5";
        sha256 = "sha256-WfN4OnAi8t0RlC5couVdamRQ76YielDrAS2WDregstI=";
      };
      pyproject = true;
      propagatedBuildInputs = with python.pkgs; [
        psutil
        xvfbwrapper
      ];
      build-system = with python.pkgs; [ setuptools ];
    };
    kibot = python.pkgs.buildPythonPackage {
      pname = "kibot";
      version = "v1.8.4";
      src = pkgs.fetchFromGitHub {
        owner = "INTI-CMNB";
        repo = "kibot";
        rev = "v1.8.4";
        sha256 = "sha256-08AQ4SpO9NohZH6Hj2E2y+9c2Bsx/cS+KhKVz5KOIcY=";
      };
      propagatedBuildInputs = with python.pkgs; [
        pyyaml
        xlsxwriter
        colorama
        requests
        qrcodegen
        markdown2
        lark
        kiauto
        lxml
      ] ++ (with pkgs; [
        imagemagick
        ghostscript
        blender
        librsvg
        kikit
      ]);
      postInstall = ''
        find $out -type d -name "__pycache__" -prune -exec rm -rf {} +
      '';
      pyproject = true;
      build-system = with python.pkgs; [ setuptools ];
    };*/
  in {
    packages.pkgs = pkgs;
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        kibotPackages.kibot
      ];
    };
  });
}
