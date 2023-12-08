# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  CSIuKeyBindings =
    (builtins.fromTOML (builtins.readFile ./key-bindings.toml)).key_bindings;
in
{
  options = {
    CSIuSupport = lib.mkEnableOption "Enable CSIu support";
  };
  config =
    with lib;
    mkMerge [
      (mkIf (cfg.enable && pkgs.stdenv.isLinux) (
        mkModulePath {
          settings = {
            key_bindings = mkIf cfg.CSIuSupport CSIuKeyBindings;
          };
        }
      ))
    ];
}
