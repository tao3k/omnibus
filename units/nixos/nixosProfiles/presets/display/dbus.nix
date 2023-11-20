# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ config, pkgs, ... }:
{
  services.dbus = {
    enable = true;
    packages =
      with pkgs;
      [
        pass-secret-service
        gcr
      ]
      ++ lib.optionals config.programs.dconf.enable [ dconf ];
  };
  services.passSecretService = {
    enable = true;
  };
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
