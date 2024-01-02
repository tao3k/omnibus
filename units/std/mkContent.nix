{
  flops,
  inputs,
  lib,
  root,
}:
top:
let
  inherit (inputs) std;
  inherit (top) projectRoot;
  inherit (flops) recursiveMerge;
in
recursiveMerge [
  {
    inputs = {
      projectRoot = top.projectRoot;
      omnibusStd = root;
      inherit std;
    };
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
    cellBlocks = with std.blockTypes; [
      (data "configs")
      (data "data")
      (installables "packages" { ci.build = true; })
      # runnables
      (runnables "scripts")
      (runnables "tasks")

      (functions "devshellProfiles")
      (devshells "shells")
      (super.blockTypes.jupyenv "jupyenv")

      (nixago "nixago")
      (containers "containers" { ci.publish = true; })
      (functions "lib")
      (functions "pops")
    ];
  }
  (lib.removeAttrs top [ "projectRoot" ])
]
