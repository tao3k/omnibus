{ config, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-pgtk;
      alwaysEnsure = true;
      extraEmacsPackages = p: with p; [ use-package ];
      config = ./init.el;
      override =
        epkgs:
        epkgs
        // {
          telega = epkgs.melpaPackages.telega.override {
            # inherit (epkgs.melpaPackages) telega;
            tdlib = pkgs.tdlib.overrideAttrs (
              _old: rec {
                version = "1.8.0";
                src = pkgs.fetchFromGitHub {
                  owner = "tdlib";
                  repo = "td";
                  rev = "v${version}";
                  sha256 = "OBgzFBi+lIBbKnHDm5D/F3Xi4s1x4geb+1OoBP3F+qY=";
                };
              }
            );
          };
        };
    };
  };
}
