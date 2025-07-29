{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.firefox;

  mkLockedValue = v: {
    Value = v;
    Status = "locked";
  };
in
{
  options.gravelOS.desktop.firefox = {
    policies.enable = lib.mkOption {
      default = false;
      example = true;
      description = "Whether to set Firefox's browser policies.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.policies.enable {
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
        "browser.startup.page" = mkLockedValue 3;
        "browser.urlbar.scotchBonnet.enableOverride" = mkLockedValue false;
        "media.videocontrols.picture-in-picture.video-toggle.has-used" = mkLockedValue true;
        "media.videocontrols.picture-in-picture.urlbar-button.enabled" = mkLockedValue false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = mkLockedValue true;
      };
    };
  };
}
