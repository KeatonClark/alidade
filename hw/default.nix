{
  stdenvNoCC,
  kicad,
  kibotPackages,
}:
stdenvNoCC.mkDerivation {
  name = "alidade-hw";
  src = ./.;
  buildInputs = [
    kicad
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
