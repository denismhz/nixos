{pkgs}:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "denismhz";
    repo = "sddm-sugar-dark";
    rev = "de4e79553ad7f71a22319354ba6b9bc07df0ca95";
    sha256 = "sha256-TN8Us2eDZHBm+OtUvFIysLL5J/6Wzbp0rCWe8u2ZyJI=";
  };
  
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}

