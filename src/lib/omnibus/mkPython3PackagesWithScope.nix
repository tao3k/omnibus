_:
{
  python3Packages,
  python3,
  lib,
  __inputs__,
}:
let
  inherit (lib) makeScope;
  inherit (python3Packages) newScope;
  inherit (__inputs__) callPackagesWithLoader __load__;
  src = __load__.src;
in
makeScope newScope (
  selfScope: callPackagesWithLoader selfScope (src + "/by-loader/python3Packages")
)
