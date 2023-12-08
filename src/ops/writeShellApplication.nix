# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

_:
{nixpkgs}:
let
  l = nixpkgs.lib // builtins;
in
{
  name,
  text,
  runtimeInputs ? [],
  runtimeEnv ? {},
  runtimeShell ? nixpkgs.runtimeShell,
  checkPhase ? null,
}:
let
  runtimeShell' =
    if runtimeShell != nixpkgs.runtimeShell then
      (l.getExe runtimeShell)
    else
      runtimeShell;
  text' = if l.isPath text then nixpkgs.lib.fileContents text else text;
in
nixpkgs.writeTextFile {
  inherit name;
  executable = true;
  destination = "/bin/${name}";
  text =
    ''
      #!${runtimeShell'}
      # shellcheck shell=bash
      set -o errexit
      set -o nounset
      set -o pipefail

    ''
    + l.optionalString (runtimeInputs != []) ''
      export PATH="${l.makeBinPath runtimeInputs}:$PATH"
    ''
    + l.optionalString (runtimeEnv != {}) ''
      ${l.concatStringsSep "\n" (
        l.mapAttrsToList (n: v: "export ${n}=${''"$''}{${n}:-${toString v}}${''"''}")
          runtimeEnv
      )}
    ''
    + ''

      ${text'}
    '';

  checkPhase =
    if checkPhase == null then
      ''
        runHook preCheck
        ${nixpkgs.stdenv.shellDryRun} "$target"
        ${nixpkgs.shellcheck}/bin/shellcheck "$target"
        runHook postCheck
      ''
    else
      checkPhase;

  meta.mainProgram = name;
}
