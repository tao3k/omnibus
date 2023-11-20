# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ pkgs, ... }:
{
  services.yubikey-agent.enable = true;

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubico-piv-tool
  ];

  services.udev.packages = [ pkgs.yubikey-personalization ];
}
