{pkgs}:

pkgs.stdenv.mkDerivation {
  name = "sddm-sugar-dracula";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "denismhz";
    repo = "sddm-sugar-dracula";
    rev = "751eb5f5fc5dde00240779c7983e27e31a9aecdf";
    sha256 = "sha256-088QlUyCQcpEZEXOz9GUt6urgdAqh9xdJKlEWyhJvj0=";
  };
  
  installPhase = ''
    mkdir -p $out/share/sddm/themes/sddm-sugar-dracula
    cp -aR ./* $out/share/sddm/themes/sddm-sugar-dracula
    cp -a ./denis.jpg $out/share/sddm/faces
  '';
}

