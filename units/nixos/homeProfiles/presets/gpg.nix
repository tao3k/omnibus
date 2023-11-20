# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config,
  lib,
  pkgs,
  ...
}:
{
  config =
    with lib;
    mkMerge [
      {
        programs.gpg = {
          enable = true;
          settings = {
            cert-digest-algo = "SHA512";
            disable-cipher-algo = "3DES";
            default-recipient-self = true;
            use-agent = true;
            with-fingerprint = true;
          };
        };
      }
      (mkIf pkgs.stdenv.isLinux {
        programs.gpg = {
          # settings = {
          #   default-key = "0x761C8EBEA940960E";
          # };
        };
        services.gpg-agent = {
          defaultCacheTtl = 180000;
          defaultCacheTtlSsh = 180000;
          enable = true;
          enableScDaemon = true;
          enableSshSupport = true;
          grabKeyboardAndMouse = false;
        };
      })
    ];
}
