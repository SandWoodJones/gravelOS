# TODO: checkout https://github.com/yokoffing/Betterfox

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.firefox;

  mkLockedSet = s: s // { Locked = true; };
  mkLockedValue = v: {
    Value = v;
    Status = "locked";
  };

  mkFlatPreferences = lib.gravelOS.mkAttrsFlatStr {
    isLeaf = (v: builtins.isAttrs v && v ? "Value" && v ? "Status");
  };
in
lib.mkIf cfg.enable {
  programs.firefox.policies = {
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    OfferToSaveLoginsDefault = false;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    OverrideFirstRunPage = "";
    DisableProfileImport = true;
    NewTabPage = true;

    EnableTrackingProtection = mkLockedSet {
      Value = true;
      Cryptomining = true;
      Fingerprinting = true;
      EmailTracking = true;
    };

    FirefoxHome = mkLockedSet {
      Search = true;
      TopSites = true;
      SponsoredTopSites = false;
      Highlights = false;
    };

    GenerativeAi = mkLockedSet {
      Chatbot = false;
      LinkPreviews = false;
      TabGroups = false;
    };

    Preferences = mkFlatPreferences {
      toolkit.legacyUserProfileCustomizations.stylesheets = mkLockedValue true;

      privacy = {
        globalprivacycontrol.enabled = mkLockedValue true;
        trackingprotection.allow_list = {
          baseline.enabled = mkLockedValue true;
          convenience.enabled = mkLockedValue true;
        };
      };
      browser = {
        aboutConfig.showWarning = mkLockedValue false;
        uidensity = mkLockedValue 1;
        startup.page = mkLockedValue 3;
        ml.chat.menu = mkLockedValue false;

        urlbar = {
          suggest.trending = mkLockedValue false;
          scotchBonnet.enableOverride = mkLockedValue false;
        };
        translations = {
          automaticallyPopup = mkLockedValue false;
          neverTranslateLanguages = mkLockedValue "pt";
        };
        gesture = {
          swipe.left = mkLockedValue "";
          swipe.right = mkLockedValue "";
        };
      };
      media.videocontrols.picture-in-picture = {
        video-toggle.has-used = mkLockedValue true;
        urlbar-button.enabled = mkLockedValue false;
      };
    };
  };
}
