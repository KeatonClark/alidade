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
    sha256 = "sha256-4ax/i7cA8xFEGxMtbWqcIJIC+IIDyK8Nft9hagRytLE=";
  };
})
