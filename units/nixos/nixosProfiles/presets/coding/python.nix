{ pkgs, lib, ... }:
let
  cfg = config.omnibus.coding.python;
  pythonEnv =
    (pkgs.python3.withPackages (
      ps:
      with ps;
      (lib.optionals cfg.emacs-eaf [
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
      ])
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
      ++ [
        pytest
        #orgparse
        pytest
        jupyter
        #voila
        pygments
        # orgbabelhelper
        # jupyterlab
        pdftotext
        openai
      ]
      ++ lib.optionals pkgs.stdenv.isLinux [
        # pyqt6
        # pyqt6-webengine
        pyinotify
        pymupdf
        # eaf depencencies
        lxml
      ]
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
    ++ lib.optionals pkgs.stdenv.isLinux [ ]
  ;
}
