{
  python3Packages,
  stdenvNoCC,
  mkdocsFetchFiles,
  alidade-hw,
}:
stdenvNoCC.mkDerivation {
  name = "alidade-docs";
  src = ./.;
  buildInputs = with python3Packages; [
    mkdocs
    mkdocs-material
    mkdocsFetchFiles
  ];
  buildPhase = ''
    mkdocs build
  '';
  installPhase = ''
    mkdir -p $out/share/alidade/html
    cp -r site/* $out/share/alidade/html
  '';
  env = {
    ALIDADE_HW = "${alidade-hw}/share/alidade";
  };
}
