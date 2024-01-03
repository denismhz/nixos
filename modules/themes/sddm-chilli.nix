{pkgs}:


pkgs.stdenv.mkDerivation rec {
  name = "kde-plasma-chili";
  dontBuild = true;
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "kde-plasma-chili";
    rev = "a371123959676f608f01421398f7400a2f01ae06";
    sha256 = "sha256-fWRf96CPRQ2FRkSDtD+N/baZv+HZPO48CfU5Subt854=";
  };

  src2 = ./background.png;
  
  installPhase = ''
    a=$(echo ${src2} | sed 's/\//\\\//g')
    echo "$a"
    sed -i "s/Background=components\/artwork\/background\.jpg/Background=$a/" theme.conf
    sed -i 's/1366/2560/' theme.conf
    sed -i 's/768/1600/' theme.conf
    mkdir -p $out/share/sddm/themes/sddm-chili
    cp -aR ./* $out/share/sddm/themes/sddm-chili
  '';
}