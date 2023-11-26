# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  casks = lib.subtractLists cfg.__profiles__.casks.removePackagesFromProfiles (
    lib.optionals cfg.__profiles__.enableReaders [
      "koodo-reader"
      "skim"
    ]
    ++ (lib.optionals cfg.__profiles__.enableShell [
      "wez/wezterm/wezterm-nightly"
    ])
    ++ (lib.optionals cfg.__profiles__.enableChat [
      "telegram-desktop"
      "signal-desktop"
      "element-desktop"
    ])
    ++ (lib.optionals cfg.__profiles__.enableSecurity [ "secretive" ])
    ++ (lib.optionals cfg.__profiles__.enableContainers [ "docker" ])
    ++ (lib.optionals cfg.__profiles__.enableChinese [ "squirrel" ])
    ++ (lib.optionals cfg.__profiles__.enableCustomization [ "bartender" ])
    ++ (lib.optionals cfg.__profiles__.enableFonts [
      "fontconfig"
      "font-material-icons"
      "font-3270-nerd-font"
      "font-fira-mono-nerd-font"
      "font-fantasque-sans-mono"
      "font-fontaesome"
    ])
  );
  brews = lib.subtractLists cfg.__profiles__.brews.removePackagesFromProfiles (
    lib.optionals cfg.__profiles__.enableEmacs [ "emacs-plus@29" ]
    ++ (lib.optionals cfg.__profiles__.enableFonts [
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
    enableReaders = mkEnableOption (lib.mdDoc "Whether to enable readers profile");
    enableShell = mkEnableOption (lib.mdDoc "Whether to enable shell profile");
    enableChat = mkEnableOption (lib.mdDoc "Whether to enable chat profile");
    enableSecurity = mkEnableOption (
      lib.mdDoc "Whether to enable security profile"
    );
    enableContainers = mkEnableOption (
      lib.mdDoc "Whether to enable containers profile"
    );
    enableChinese = mkEnableOption (lib.mdDoc "Whether to enable chinese profile");
    enableFonts = mkEnableOption (lib.mdDoc "Whether to enable fonts profile");
    enableEmacs = mkEnableOption (lib.mdDoc "Whether to enable emacs profile");
    enableCustomization = mkEnableOption (
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
      (mkModulePath { inherit casks brews; })
      (mkIf cfg.__profiles__.default (
        mkModulePath {
          taps = [
            "homebrew/bundle"
            "homebrew/core"
          ];
        }
      ))
      (mkIf (cfg.casks != [ ]) (
        mkModulePath {
          taps = [
            "homebrew/cask"
            "homebrew/cask-versions"
          ];
        }
      ))
      (mkIf cfg.__profiles__.fonts (
        mkModulePath { taps = [ "homebrew/cask-fonts" ]; }
      ))
      (mkIf cfg.__profiles__.emacs (
        mkModulePath { taps = [ "d12frosted/emacs-plus" ]; }
      ))
    ];
}
