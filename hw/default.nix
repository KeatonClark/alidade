{
  stdenvNoCC,
  kibotPackages,
  python3Packages,
}:
stdenvNoCC.mkDerivation {
  name = "alidade-hw";
  src = ./.;
  buildInputs = [
    python3Packages.kicad
    kibotPackages.kibot
    kibotPackages.kidiff
  ];
  preBuild = ''
    export HOME=$(mktemp -d)
  '';
  makeFlags = ''
    PREFIX=$$out
  '';
}
