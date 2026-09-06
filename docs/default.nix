{
  python3Packages,
  stdenvNoCC,
  mkdocs-fetch-files-plugin,
  alidade-hw,
}:
stdenvNoCC.mkDerivation {
  name = "alidade-docs";
  src = ./.;
  buildInputs = with python3Packages; [
    mkdocs
    mkdocs-material
    mkdocs-fetch-files-plugin
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
