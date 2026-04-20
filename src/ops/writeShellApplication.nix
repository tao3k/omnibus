# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

_:
{ nixpkgs }:
let
  l = nixpkgs.lib // builtins;
in
{
  name,
  text,
  runtimeInputs ? [ ],
  runtimeEnv ? { },
  runtimeShell ? nixpkgs.runtimeShell,
  checkPhase ? null,
  passthru ? { },
}:
let
  /**
    Resolve non-default shells through `getExe` so callers can pass either a
    package or a concrete shell path.
  */
  runtimeShell' =
    if runtimeShell != nixpkgs.runtimeShell then (l.getExe runtimeShell) else runtimeShell;

  /**
    Keep file-backed script fragments supported without forcing callers to read
    them manually.
  */
  text' = if l.isPath text then nixpkgs.lib.fileContents text else text;

  /**
    Render runtime environment defaults as shell literals instead of embedding
    them directly in parameter expansion. This avoids evaluating command
    substitutions such as `$(...)` from the default value while preserving the
    existing "use default when unset or empty" behavior.
  */
  runtimeEnvExport =
    name: value:
    let
      shellValue = l.escapeShellArg (toString value);
    in
    l.concatStringsSep "\n" [
      ("if [ -n \"\${" + name + ":-}\" ]; then")
      ("  export " + name + "=\"\${" + name + "}\"")
      "else"
      ("  export " + name + "=" + shellValue)
      "fi"
    ];
in
nixpkgs.writeTextFile {
  inherit name;
  executable = true;
  destination = "/bin/${name}";
  text = ''
    #!${runtimeShell'}
    # shellcheck shell=bash
    set -o errexit
    set -o nounset
    set -o pipefail

  ''
  + l.optionalString (runtimeInputs != [ ]) ''
    export PATH="${l.makeBinPath runtimeInputs}:$PATH"
  ''
  + l.optionalString (runtimeEnv != { }) ''
    ${l.concatStringsSep "\n" (l.mapAttrsToList runtimeEnvExport runtimeEnv)}
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

  passthru = passthru // {
    inherit runtimeInputs;
  };
  meta.mainProgram = name;
}
