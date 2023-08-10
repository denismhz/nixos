{pkgs}:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "denismhz";
    repo = "sddm-sugar-dark";
    rev = "9fbb6d684b27fbe97b9f6edfa4c2210304f7f020";
    sha256 = "sha256-LAhxkrRRf4quz8M1MmDlaCxuWKtqPlIhSriYXuuAynU=";
  };
  
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}

