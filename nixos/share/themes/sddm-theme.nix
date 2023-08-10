{pkgs}:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "denismhz";
    repo = "sddm-sugar-dark";
    rev = "9bdcb9cb6238f859baba8f68df9418d8f7197d50";
    sha256 = "sha256-FT8fualZne6VH48NtWadGi13qgCt+O71aFJCZpSnWfw=";
  };
  
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}

