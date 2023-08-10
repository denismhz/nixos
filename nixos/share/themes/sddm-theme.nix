{pkgs}:

	pkgs.stdenv.mkDerivation {
		name = "sddm-theme";
		src = pkgs.fetchFromGitHub {
			owner = "denismhz";
			repo = "sddm-sugar-dark";
			rev = "b8ee3390bc8631ec47ea5ed1ed995bf7d9ea25d4";
			sha256 = "sha256-ibijEqXxn6Sy6p6t+OgprWbIKg5HCWdfJk4243Tk6SI=";
		};
		
		installPhase = ''
			mkdir -p $out
			cp -R ./* $out/
		'';
	}

