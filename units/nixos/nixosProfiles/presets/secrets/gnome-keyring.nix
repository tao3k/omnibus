# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

_:
{pkgs, ...}:
{
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  environment.systemPackages = with pkgs; [libsecret];
}
