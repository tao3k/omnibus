{ inputs, cell }@commonArgs:
let
  inherit (inputs)
    omnibusStd
    cellsFrom
    cellsFrom'
    _pops
    ;
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
    shells = {
      src = cellsFrom + /${cellName}/shells;
    };
    data = {
      src = cellsFrom' + /${cellName}/data;
    };
    packages = {
      src = cellsFrom + /${cellName}/packages;
    };
    pops = {
      src = cellsFrom + /${cellName}/pops;
    };
  }
  // _pops
)
