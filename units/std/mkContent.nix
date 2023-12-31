{
  flops,
  inputs,
  lib,
}:
top:
let
  inherit (inputs) std;
  inherit (top) projectRoot extraStd;
  inherit (flops) recursiveMerge;
in
recursiveMerge [
  (lib.removeAttrs top [ "projectRoot" ])
  {
    inputs = {
      projectRoot = top.projectRoot;
    };
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
    cellBlocks = with std.blockTypes; [
      (data "configs")
      # runnables
      (runnables "scripts")
      (runnables "tasks")

      (functions "devshellProfiles")
      (devshells "shells")
      (super.blockTypes.jupyenv "jupyenv")

      (nixago "nixago")

      (containers "containers")
      (functions "lib")
      (functions "pops")
    ];
  }
]
