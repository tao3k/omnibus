{ pkgs, lib, ... }:
let
  cfg = config.omnibus.coding.python;
  pythonEnv =
    (cfg.python.withPackages (
      ps:
      with ps;
      (
        lib.unique (
          lib.optionals cfg.emacs-eaf [
            #emacs-eaf
            shapely
            dbus-python
            qrcode
            xlib
            grip
            black
            keyring
            # pyqt5
            # pyqtwebengine
            markdown
            feedparser
            retrying
          ]
        )
        ++ (lib.optionals cfg.lsp-bridge [
          epc
          orjson
          ###
          pypinyin
          sexpdata
          six
          paramiko
          rapidfuzz
        ])
        ++ [ ]
      )
    ));
in
#.override (args: {ignoreCollisions = true;});
{
  imports = [ omnibus.nixosModules.omnibus.coding.python ];
  environment.systemPackages =
    with pkgs;
    [
      pythonEnv
      poetry
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [ ];
}
