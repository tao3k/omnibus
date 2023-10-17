{
  pkgs,
  omnibus,
  inputs,
  config,
}:
let
  inherit
    (omnibus.lib.errors.requiredInputs inputs "omnibus.pops.homeProfiles" [ "nur" ])
    nur
  ;
  cfg = config.programs.firefox;
in
{
  imports = [ omnibus.homeModules.programs.firefox ];
  programs.firefox = {
    enable = true;
    __profiles__ = {
      nurPkgs = (pkgs.extend nur.overlay).nur;
    };
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        PasswordManagerEnabled = false;
        DisableFirefoxAccounts = true;
        DisablePocket = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        Preferences = {
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.urlbar.autoFill.adaptiveHistory.enabled" = true;
          "browser.tabs.closeWindowWithLastTab" = false;
          "extensions.unifiedExtensions.enabled" = false;
        };
      };
    };
    profiles.default.extensions =
      with cfg.__profiles__.nurPkgs.repos.rycee.firefox-addons; [
        vimium
        darkreader
        privacy-badger
      ];
  };
}
