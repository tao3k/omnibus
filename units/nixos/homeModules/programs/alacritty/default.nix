# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  CSIuKeyBindings =
    (builtins.fromTOML (builtins.readFile ./key-bindings.toml)).key_bindings;
in
{
  options = with lib; {
    CSIuSupport = mkEnableOption "Enable CSIu support";
    __profiles__ = {
      enableZellij = mkEnableOption "Enable zellij profile";
    };
  };
  config =
    with lib;
    mkIf cfg.enable (mkMerge [
      (mkIf pkgs.stdenv.isLinux (mkModulePath {
        settings = {
          key_bindings = mkIf cfg.CSIuSupport CSIuKeyBindings;
        };
      }))
      (mkIf (cfg.__profiles__.enableZellij && config.programs.zellij.enable)
        (mkModulePath {
          settings = {
            shell.program = lib.getExe config.programs.zellij.package;
          };
        })
      )
    ]);
}
