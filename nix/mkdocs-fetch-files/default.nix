{ 
  python3Packages 
}:
python3Packages.buildPythonPackage {
  pname = "mkdocs-fetch-files";
  version = "0.1.0";

  src = ./.;

  pyproject = true;

  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    mkdocs
  ];

  doCheck = false;
}
