{
  fetchPypi,
  python3Packages,
}:
python3Packages.buildPythonPackage rec {
  pname = "kiauto";
  version = "2.3.5";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-WfN4OnAi8t0RlC5couVdamRQ76YielDrAS2WDregstI=";
  };
  pyproject = true;
  buildInputs = with python3Packages; [
    psutil
    xvfbwrapper
  ];
  build-system = with python3Packages; [
    setuptools
  ];
}
