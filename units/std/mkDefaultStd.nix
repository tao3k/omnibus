{
  super,
  inputs,
  lib,
}:
let
  inherit (inputs) std;
  inherit (std) incl;
  mkCellsFrom =
    src:
    std.incl src [
      "dev"
      "prod"
    ];
in
{ ... }@attrs:
super.mkStandardStd (
  lib.recursiveUpdate attrs {
    inputs = {
      cellsFrom = mkCellsFrom attrs.cellsFrom;
      # without std.incl
      cellsFrom' = attrs.cellsFrom;
    };
    cellsFrom = mkCellsFrom ./defaultCellsFrom;
  }
)
