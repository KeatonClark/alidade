{
  python3Packages,
  fetchFromGitHub,
  kibotPackages,
}:
python3Packages.buildPythonPackage rec {
  pname = "KiDiff";
  version = "v2.5.8";
  src = fetchFromGitHub {
    owner = "INTI-CMNB";
    repo = pname;
    rev = version;
    sha256 = "sha256-sYOOCVf1YdabMEjkGXkIeCIFuQ5LPqa3z9haFzp3IJM=";
  };
  pyproject = true;
  build-system = [ python3Packages.setuptools ];
  propagatedNativeBuildInputs = with python3Packages; [
  ] ++ [
    kibotPackages.kiauto
  ];
}
