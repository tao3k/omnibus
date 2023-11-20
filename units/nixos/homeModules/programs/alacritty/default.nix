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
  config = mkMerge [
    (mkIf (cfg.enable && pkgs.stdenv.isLinux) {
      programs.alacritty = {
        settings = {
          key_bindings = mkIf cfg.CSIuSupport CSIuKeyBindings;
        };
      };
    })
  ];
}
