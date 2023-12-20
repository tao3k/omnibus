{ nixpkgs, writeShellApplicationFn }:
let
  writeShellApplication = writeShellApplicationFn { inherit nixpkgs; };
  l = nixpkgs.lib // builtins;
in
{
  text ? "",
  runtimeInputs ? [ ],
  runtimeEnv ? { },
  kernels ? { },
  package ? nixpkgs.quarto,
}:
(writeShellApplication {
  name = "quarto";
  runtimeInputs = [
    package
    nixpkgs.rsync
  ] ++ runtimeInputs;
  runtimeEnv = {
    # QUARTO_R = "${rEnv}/bin/R";
  } // runtimeEnv;
  inherit text;
}).overrideAttrs
  (
    old: {
      passthru = {
        quarto = package;
      };
    }
  )
