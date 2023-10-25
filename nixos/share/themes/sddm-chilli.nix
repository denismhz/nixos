{pkgs}:

pkgs.stdenv.mkDerivation {
  name = "kde-plasma-chilli";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "kde-plasma-chili";
    rev = "a371123959676f608f01421398f7400a2f01ae06";
    sha256 = "sha256-fWRf96CPRQ2FRkSDtD+N/baZv+HZPO48CfU5Subt854=";
  };
  
  installPhase = ''
    mkdir -p $out/share/sddm/themes/sddm-chilli
    cp -aR ./* $out/share/sddm/themes/sddm-chilli
  '';
}