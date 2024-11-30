{ pkgs, ... }:
let
  mkLockedValue = v: { Value = v; Status = "locked"; };
in {
  config = {
    programs.firefox = {
      enable = true;

      policies = {
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        OverrideFirstRunPage = "";
        DisableProfileImport = true;
        NewTabPage = true;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        FirefoxHome = {
          Search = true;
          TopSites = true;
          SponsoredTopSites = false;
          Highlights = false;
          Locked = true;         
        };

        Preferences = {
          "browser.aboutConfig.showWarning" = mkLockedValue false;
          "browser.translations.automaticallyPopup" = mkLockedValue false;
          "browser.translations.neverTranslateLanguages" = mkLockedValue "pt";
          "browser.gesture.swipe.left" = mkLockedValue "";
          "browser.gesture.swipe.right" = mkLockedValue "";
          "browser.uidensity" = mkLockedValue 1;
          "media.videocontrols.picture-in-picture.video-toggle.has-used" = mkLockedValue true;
          "media.videocontrols.picture-in-picture.urlbar-button.enabled" = mkLockedValue false;
          "apz.overscroll.enabled" = mkLockedValue false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = mkLockedValue true;
          "reader.parse-on-load" = mkLockedValue false;
        };
      };

      profiles.default = {
        containers = {};
        containersForce = true;
        userChrome = builtins.readFile ./userChrome.css;

        search = {
          force = true;
          default = "Google";
          engines = {
            "Bing".metaData.hidden = true;
            "DuckDuckGo".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;

            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              definedAliases = [ "@np" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            };

            "NixOS Options" = {
              urls = [{
                template = "https://search.nixos.org/options";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              definedAliases = [ "@no" ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            };

            "Home Manager Options" = {
              urls = [{
                template = "https://home-manager-options.extranix.com";
                params = [
                  { name = "release"; value = "master"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              definedAliases = [ "@hm" ];
              icon = pkgs.fetchurl {
                url = "https://nix-community.org/nix-community-logo.svg";
                hash = "sha256-knHbAsCVhSW8Ucc24nhwakLezw2QCRjvi/Plz3QDas4=";
              };
            };
            
            "YouTube" = {
              urls = [{
                template = "https://www.youtube.com/results";
                params = [
                  { name = "search_query"; value = "{searchTerms}"; }
                ];
              }];

              definedAliases = [ "@yt" ];
              icon = pkgs.fetchurl {
                url = "https://upload.wikimedia.org/wikipedia/commons/f/fd/YouTube_full-color_icon_%282024%29.svg";
                name = "youtube-icon.svg";
                hash = "sha256-8igmt9medFu9pU3EIcLC8IY3OyAMXn97QExNecPfaOI=";
              };
            };
          };

          order = [ "YouTube" "Nix Packages" "NixOS Options" "Home Manager Options" ];
        };
      };
    }; 
  };
}
