# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  config,
  lib,
  ...
}:
{
  virtualisation.docker.enable =
    lib.mkIf config.virtualisation.podman.dockerSocket.enable
      (lib.mkForce false);

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui
  ];
}
