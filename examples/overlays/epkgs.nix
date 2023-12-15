{ root }:
let
  pkgs = root.pops.flake.inputs.nixpkgs.legacyPackages.x86_64-linux;
  overlay = final: prev: {
    # TODO include other files?
    typst-ts-mode = final.elpaBuild {
      pname = "typst-ts-mode";
      version = "0.8.0";
      src = pkgs.fetchurl {
        url = "https://git.sr.ht/~meow_king/typst-ts-mode/blob/main/typst-ts-mode.el";
        hash = "sha256-s3izs8ed65tqhvWZVa9+o/ZFJlliw+fEtu/4AHnPgyI=";
      };
    };
  };
in
(pkgs.emacs29.pkgs.overrideScope overlay).withPackages (
  epkgs: [ epkgs.typst-ts-mode ]
)
