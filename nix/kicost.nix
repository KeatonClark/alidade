{
  python3Packages,
  fetchFromGitHub,
  python313Packages,
}:
python3Packages.buildPythonPackage rec {
  pname = "KiCost";
  version = "v1.1.20";
  src = fetchFromGitHub {
    owner = "hildogjr";
    repo = pname;
    rev = version;
    sha256 = "sha256-2cJIiF8rZ0mHCO4aCTLTTazLBfGAlcj9u8HvRs5robs=";
  };
  pyproject = true;
  build-system = [ python3Packages.setuptools ];
  nativeBuildInputs = with python3Packages; [
    requests
    beautifulsoup4
    xlsxwriter
  ] ++ [
    python313Packages.validators
  ];
  propagatedNativeBuildInputs = with python3Packages; [
    lxml
    tqdm
    wxpython
    colorama
    pyyaml
  ];
}
