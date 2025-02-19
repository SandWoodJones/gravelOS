{ pkgs }: {
  "Nix Packages" = {
    definedAliases = [ "@np" ];
    urls = [{
      template = "https://search.nixos.org/packages";
      params = [
        { name = "channel"; value = "unstable"; }
        { name = "query"; value = "{searchTerms}"; }
      ];
    }];

    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  };

  "NixOS Options" = {
    definedAliases = [ "@no" ];
    urls = [{
      template = "https://search.nixos.org/options";
      params = [
        { name = "channel"; value = "unstable"; }
        { name = "query"; value = "{searchTerms}"; }
      ];
    }];

    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  };

  "Home Manager Options" = {
    definedAliases = [ "@hm" ];
    urls = [{
      template = "https://home-manager-options.extranix.com";
      params = [
        { name = "release"; value = "master"; }
        { name = "query"; value = "{searchTerms}"; }
      ];
    }];

    icon = pkgs.fetchurl {
      url = "https://nix-community.org/nix-community-logo.svg";
      hash = "sha256-knHbAsCVhSW8Ucc24nhwakLezw2QCRjvi/Plz3QDas4=";
    };
  };

   "Noogle" = {
    definedAliases = [ "@ng" ];
    urls = [{
      template = "https://noogle.dev/q";
      params = [
        { name = "term"; value = "{searchTerms}"; }
        { name = "limit"; value = "100"; }
      ];
    }];

    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  };

  "YouTube" = {
    definedAliases = [ "@yt" ];
    urls = [{
      template = "https://www.youtube.com/results";
      params = [
        { name = "search_query"; value = "{searchTerms}"; }
      ];
    }];

    icon = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/f/fd/YouTube_full-color_icon_%282024%29.svg";
      name = "youtube-icon.svg";
      hash = "sha256-8igmt9medFu9pU3EIcLC8IY3OyAMXn97QExNecPfaOI=";
    };
  };

  "Bing".metaData.hidden = true;
  "DuckDuckGo".metaData.hidden = true;
  "Wikipedia (en)".metaData.hidden = true;
}
