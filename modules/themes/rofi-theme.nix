{pkgs}:

pkgs.stdenv.mkDerivation {
  name = "rofi-dracula";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "rofi";
    rev = "459eee340059684bf429a5eb51f8e1cc4998eb74";
    sha256 = "sha256-Zx/+FLd5ocHg6+YkqOt67nWfeHR3+iitVm1uKnNXrzc=";
  };
  
  installPhase = ''
    mkdir -p $out/share/rofi/themes/rofi-dracula
    cp -aR ./* $out/share/rofi/themes/rofi-dracula
  '';
}
