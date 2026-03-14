{pkgs, ...}: {
  mpv = {
    enable = true;
    extraInput = ''
      Del run "rm" "''${path}"; playlist_next
    '';

    config = {
      playlist = "no";
      keep-open = "always";
      reset-on-next-file = "pause";
    };
    scripts = with pkgs; [
      mpvScripts.mpris
      mpvScripts.autoload
      mpvScripts.uosc
    ];
  };
}
