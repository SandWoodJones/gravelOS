let
  mkLockedValue = v: { Value = v; Status = "locked"; };
in {
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
}
