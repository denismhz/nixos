{ stdenv
, lib
, qtbase
, qtdeclarative
, qtlocation
, qtwebchannel
, qtwebengine
, qtpositioning
, qtutilities
, qwt
, wrapQtAppsHook
, fetchFromGitHub
, git
, libX11
, libxcb
, steam-run
}:

stdenv.mkDerivation rec {
  pname = "whatsie";
  version = "4.14.1";

  src = fetchFromGitHub {
    owner = "keshavbhatt";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-+Y6HaxwfsDo8+Zz1tSF606zHSWq3tdPRuIssDhlIIRg=";
  };

  buildInputs = [ qtbase qtdeclarative qtlocation qtwebchannel qtwebengine qtpositioning qtutilities qwt ];
  nativeBuildInputs = [ wrapQtAppsHook git libX11 libxcb ];
  
  env = {
    QT_WEBENGINE_ICU_DATA_DIR = "${qtwebengine.out}/resources";
  };

  buildPhase = lib.strings.concatStrings [''
    cd src
    qmake
    make
    cd ..
  ''];

  # nix-shell -p 'with import <nixpkgs> { config.allowUnfree = true; }; libsForQt5.callPackage ./default.nix {}'
  # sed -i '675i\''  "\t" ''export QT_WEBENGINE_ICU_DAT_DIR="/nix/store/4w7m1cgfqysjgb8d6i617if12mvam12s-qtwebengine-5.15.13/resources"\' Makefile
  # sed -i 675's/\'' "\t" ''.*/\'' "\t" ''QT_WEBENGINE_ICU_DAT_DIR="\/nix\/store\/4w7m1cgfqysjgb8d6i617if12mvam12s-qtwebengine-5.15.13\/resources" &/' Makefile

  installPhase = ''
    export INSTALL_ROOT="$TEMP"
    cd src
    make install
    cd ..
    mkdir -p $out/bin
    mv $INSTALL_ROOT/usr/bin/whatsie $out/bin/
    mv $INSTALL_ROOT/usr/share/ $out/share
    sed -i 's/Exec=whatsie/Exec=steam-run whatsie/g' $out/share/applications/com.ktechpit.whatsie.desktop
    ls -alR $out
  '';

  meta = with lib; {
    description = "Fast Light weight WhatsApp Client based on Qt's WebEngine, With lots of settings and packed goodies";
    longDescription = ''
      Feature rich WhatsApp web client based on Qt WebEngine for Linux Desktop
      Fast Light weight WhatsApp Client based on Qt's WebEngine, With lots of settings and packed goodies
    '';
    homepage = "https://github.com/keshavbhatt/${pname}";
    changelog = "https://github.com/keshavbhatt/${pname}/compare/v4.14.0...v${version}";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
