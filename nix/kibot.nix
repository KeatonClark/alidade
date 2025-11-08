{
  python3Packages,
  fetchFromGitHub,
  imagemagick,
  ghostscript,
  blender,
  librsvg,
  kibotPackages
}:
python3Packages.buildPythonPackage rec {
  pname = "KiBot";
  version = "v1.8.4";
  src = fetchFromGitHub {
    owner = "INTI-CMNB";
    repo = pname;
    rev = version;
    sha256 = "sha256-08AQ4SpO9NohZH6Hj2E2y+9c2Bsx/cS+KhKVz5KOIcY=";
  };
  postInstall = ''
    find $out -type d -name "__pycache__" -prune -exec rm -rf {} +
  '';
  pyproject = true;
  build-system = [ python3Packages.setuptools ];
  propagatedNativeBuildInputs = with python3Packages; [
    pyyaml
    xlsxwriter
    colorama
    requests
    qrcodegen
    markdown2
    lark
    pandoc
    lxml
  ] ++ (with kibotPackages; [
    kiauto
    kidiff
    kikit
  ]) ++ [
    imagemagick
    ghostscript
    blender
    librsvg
  ];
}
