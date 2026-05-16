{
  fetchFromGitHub,
  kikit,
}:
kikit.overrideAttrs (old: rec { 
  pname = "KiKit";
  version = "v1.7.2-1";
  src = fetchFromGitHub {
    owner = "INTI-CMNB";
    repo = pname;
    rev = version;
    sha256 = "sha256-IBma9TRZ/x5m3vErvK+Z1BRWGD2ViOe7rdOGYRiIzHE=";
  };
})
