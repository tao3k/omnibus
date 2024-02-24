# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ pkgs, ... }:
{
  # FIXME: dropox missing module named 'gi'  https://github.com/NixOS/nixpkgs/issues/235345
  systemd.user.services.maestral = {
    Unit = {
      Description = "maestral daemon";
    };
    Install.WantedBy = [ "default.target" ];
    Service.ExecStart = "${pkgs.maestral}/bin/maestral start --foreground";
  };
  home.packages = [
    pkgs.maestral-gui
    pkgs.maestral
  ];
  # services.dropbox = {
  #   enable = true;
  # };
}
