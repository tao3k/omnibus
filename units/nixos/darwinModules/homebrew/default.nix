let
  casks = lib.subtractLists cfg.__profiles__.casks.removePackagesFromProfiles (
    lib.optionals cfg.__profiles__.readers [
      "koodo-reader"
      "skim"
    ]
    ++ (lib.optionals cfg.__profiles__.shell [ "wez/wezterm/wezterm-nightly" ])
    ++ (lib.optionals cfg.__profiles__.chat [
      "telegram-desktop"
      "signal-desktop"
      "element-desktop"
    ])
    ++ (lib.optionals cfg.__profiles__.security [ "secretive" ])
    ++ (lib.optionals cfg.__profiles__.containers [ "docker" ])
    ++ (lib.optionals cfg.__profiles__.chinese [ "squirrel" ])
    ++ (lib.optionals cfg.__profiles__.customization [ "bartender" ])
    ++ (lib.optionals cfg.__profiles__.fonts [
      "font-fantasque-sans-mono"
      "font-fontawesome"
    ])
  );
  brews = lib.subtractLists cfg.__profiles__.brews.removePackagesFromProfiles (
    lib.optionals cfg.__profiles__.emacs [ "emacs-plus@29" ]
    ++ (lib.optionals cfg.__profiles__.fonts [
      "fontconfig"
      "rxvt-unicode"
    ])
  );
in
{
  options.__profiles__ = with lib; {
    default = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable default profile";
    };
    readers = mkEnableOption (lib.mdDoc "Whether to enable readers profile");
    shell = mkEnableOption (lib.mdDoc "Whether to enable shell profile");
    chat = mkEnableOption (lib.mdDoc "Whether to enable chat profile");
    security = mkEnableOption (lib.mdDoc "Whether to enable security profile");
    containers = mkEnableOption (lib.mdDoc "Whether to enable containers profile");
    chinese = mkEnableOption (lib.mdDoc "Whether to enable chinese profile");
    fonts = mkEnableOption (lib.mdDoc "Whether to enable fonts profile");
    emacs = mkEnableOption (lib.mdDoc "Whether to enable emacs profile");
    customization = mkEnableOption (
      lib.mdDoc "Whether to enable customization profile"
    );

    casks = {
      removePackagesFromProfiles = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "List of packages to remove from cask profiles";
      };
    };
    brews = {
      removePackagesFromProfiles = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "List of packages to remove from brew profiles";
      };
    };
  };

  config =
    with lib;
    mkMerge [
      { inherit casks brews; }
      (mkIf cfg.__profiles__.default {
        taps = [
          "homebrew/bundle"
          "homebrew/core"
        ];
      })
      (mkIf (cfg.casks != [ ]) {
        taps = [
          "homebrew/cask"
          "homebrew/cask-versions"
        ];
      })
      (mkIf cfg.__profiles__.fonts { taps = [ "homebrew/cask-fonts" ]; })
      (mkIf cfg.__profiles__.emacs { taps = [ "d12frosted/emacs-plus" ]; })
    ];
}
