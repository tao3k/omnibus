# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ pkgs, omnibus }:
{
  imports = [ omnibus.jupyenv.quarto ];
  publishers.quarto.enable = true;
  kernel.bash.omnibus = {
    enable = true;
    runtimePackages = [ pkgs.git ];
  };
}
