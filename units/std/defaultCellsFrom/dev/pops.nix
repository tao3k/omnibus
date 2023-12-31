{ inputs, cell }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom _pops;
  cellName = builtins.baseNameOf ./.;
in
omnibusStd.mkCells.pops commonArgs (
  {
    scripts = {
      src = cellsFrom + /${cellName}/scripts;
    };
    tasks = {
      src = cellsFrom + /${cellName}/tasks;
    };
    configs = {
      src = cellsFrom + /${cellName}/configs;
    };
    devshellProfiles = {
      src = cellsFrom + /${cellName}/devshellProfiles;
    };
  }
  // _pops
)
