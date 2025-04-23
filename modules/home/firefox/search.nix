{ pkgs }:
let
  nix-community-icon = pkgs.fetchurl {
    url = "https://nix-community.org/nix-community-logo.svg";
    name = "firefox-engine-icon-nix-community.svg";
    hash = "sha256-knHbAsCVhSW8Ucc24nhwakLezw2QCRjvi/Plz3QDas4=";
  };

  rust-icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/rust-lang/rust/d4812c8638173ec163825d56a72a33589483ec4c/src/librustdoc/html/static/images/favicon.svg";
    name = "firefox-engine-icon-rust.svg";
    hash = "sha256-BEvjkUSrMEz56g6QFMP0duDFGUxiqlJbNmnK9dtawIg=";
  };
in {
  force = true;
  default = "google";

  order = [ "youtube" "Nix Packages" "NixOS Options" "Home Manager Options" "Noogle" "Rust std" "Crates.io" "Docs.rs" "Letterboxd" "OSRS Wiki" ];
  engines = {
    youtube = {
      definedAliases = [ "@yt" ];
      urls = [{
        template = "https://www.youtube.com/results";
        params = [
          { name = "search_query"; value = "{searchTerms}"; }
        ];
      }];

      icon = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/f/fd/YouTube_full-color_icon_%282024%29.svg";
        name = "firefox-engine-icon-youtube.svg";
        hash = "sha256-8igmt9medFu9pU3EIcLC8IY3OyAMXn97QExNecPfaOI=";
      };
    };

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

      icon = nix-community-icon;
    };

    Noogle = {
      definedAliases = [ "@ng" ];
      urls = [{
        template = "https://noogle.dev/q";
        params = [
          { name = "term"; value = "{searchTerms}"; }
          { name = "limit"; value = "100"; }
        ];
      }];

      icon = nix-community-icon;
    };

    "Rust std" = {
      definedAliases = [ "@rust" ];
      urls = [{
        template = "https://doc.rust-lang.org/stable/std/index.html";
        params = [{ name = "search"; value = "{searchTerms}"; }];
      }];

      icon = rust-icon;
    };

    "Crates.io" = {
      definedAliases = [ "@crate" "@crates" ];
      urls = [{
        template = "https://crates.io/search";
        params = [
          { name = "q"; value = "{searchTerms}"; }
        ];
      }];

      icon = rust-icon;
    };

    "Docs.rs" = {
      definedAliases = [ "@docrs" "@docsrs" ];
      urls = [{
        template = "https://docs.rs/{searchTerms}";
      }];

      icon = rust-icon;
    };

    Letterboxd = {
      definedAliases = [ "@lb" ];
      urls = [{ template = "https://letterboxd.com/search/{searchTerms}"; }];

      icon = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/9/9b/Letterboxd_2023_logo.png";
        name = "firefox-engine-icon-letterboxd.svg";
        hash = "sha256-iewTIIy/ahWZVysQ8cYQaWDGMy0DRo7xG6Di/Jphts4=";
      };
    };

    "OSRS Wiki" = {
      definedAliases = [ "@rs" ];
      urls = [{
        template = "https://oldschool.runescape.wiki";
        params = [
          { name = "search"; value = "{searchTerms}"; }
        ];
      }];

      icon = pkgs.fetchurl {
        url = "https://oldschool.runescape.wiki/images/RuneScape_Classic_Runestone.png?f8010";
        name = "firefox-engine-icon-osrs.png";
        hash = "sha256-OJrZlmG+8Ruu/bmQVav58ZQPV7xhvj3g9X6JKJAva4c=";
      };
    };

    bing.metaData.hidden = true;
    ddg.metaData.hidden = true;
    wikipedia.metaData.hidden = true;
  };
}
