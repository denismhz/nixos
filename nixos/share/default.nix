{ stdenv
, lib
, cmake
, zlib
, freetype
, ninja
, fetchFromGitHub
, wrapQtAppsHook
, qtbase
, qtmultimedia
, qttools
, qtdeclarative
}:

# (libsForQt5.callPackage /.../tsMuxer/default.nix {})

stdenv.mkDerivation rec {
  pname = "tsMuxer";
  version = "nightly-2023-09-03-01-53-46";

  src = fetchFromGitHub {
    owner = "justdan96";
    repo = pname;
    rev = "27f1d540f2e54f8772142440e07fcd4da538a73c";
    sha256 = "sha256-yP7jeeiWy0dBcN/s2U6Cgn5dji8jCtmV9gOWWEgSQiA=";
  };

  nativeBuildInputs = [ cmake zlib freetype ninja wrapQtAppsHook qtbase qtmultimedia qttools qtdeclarative ];

  configurePhase = ''
    mkdir build
    cd build
    cmake ../ -G Ninja -DTSMUXER_GUI=ON
  '';

  buildPhase = ''
    ninja
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp tsMuxer/tsmuxer $out/bin/tsMuxeR
    cp tsMuxerGUI/tsMuxerGUI $out/bin/tsMuxerGUI
  '';

  meta = with lib; {
    description = "tsMuxer is a transport stream muxer for remuxing/muxing elementary streams, EVO/VOB/MPG, MKV/MKA, MP4/MOV, TS, M2TS to TS to M2TS.";
    longDescription = ''
      tsMuxer is a transport stream muxer for remuxing/muxing elementary streams, EVO/VOB/MPG, MKV/MKA, MP4/MOV, TS, M2TS to TS to M2TS.
      Supported video codecs H.264/AVC, H.265/HEVC, VC-1, MPEG2.
      Supported audio codecs AAC, AC3 / E-AC3(DD+), DTS/ DTS-HD. 
    '';
    homepage = "https://github.com/justdan96/${pname}";
    maintainers = [ ];
    platforms = platforms.all;
  };
}
