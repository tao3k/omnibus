# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita";
    style.package = pkgs.adwaita-qt;
  };
  home.packages = [ ];
  home.sessionVariables = {
    # QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    QT_PLUGIN_PATH = lib.concatStringsSep ":" [
      "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtPluginPrefix}"
      "${pkgs.qt5.qtwayland.bin}/${pkgs.qt5.qtbase.qtPluginPrefix}"
      "${pkgs.qt6.qtwayland}/lib/qt-6/plugins"
      "${pkgs.qt6.qtbase}/${pkgs.qt6.qtbase.qtPluginPrefix}"
    ];
  };
}
