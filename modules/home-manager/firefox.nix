{ inputs, pkgs, ... }:
{
  firefox = {
    enable = true;
    profiles.denis = {
      settings = {
        "browser.search.region" = "DE";
        "browser.startup.homepage" = "https://nextcloud.manherz.de";
        "browser.search.isUS" = false;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.compactmode.show" = true;
        "browser.newtabpage.pinned" = [
          {
            title = "NixOS";
            url = "https://nixos.org";
          }
          {
            title = "Jellyfin";
            url = "https://jello.manherz.de";
          }
          {
            title = "Nextcloud";
            url = "https://nextcloud.manherz.de";
          }
          {
            title = "Github";
            url = "https://github.com";
          }
          {
            title = "Git";
            url = "https://git.manherz.de";
          }
          {
            title = "Chess";
            url = "https://chess.com";
          }
          {
            title = "CivitAI";
            url = "https://civitai.com";
          }
          {
            title = "Youtube";
            url = "https://youtube.com";
          }
        ];
      };
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "Home-Manager Options" = {
          urls = [{
            template = "https://mipmip.github.io/home-manager-option-search";
            params = [
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@hm" ];
        };
      };
      search.force = true;
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        simple-tab-groups
      ];
    };
  };
}
