{ inputs, cell }@commonArgs:
let
  inherit (inputs) omnibusStd cellsFrom cellsFrom';
  inherit (inputs.nixpkgs) lib;
  cellName = builtins.baseNameOf ./.;
in
omnibusStd.mkBlocks.pops commonArgs {
  scripts = {
    src = cellsFrom + /${cellName}/scripts;
    inputs.inputs = {
      makesSrc = inputs.std.inputs.makes;
    };
  };
  tasks = {
    src = cellsFrom + /${cellName}/tasks;
    inputs.inputs = {
      makesSrc = inputs.std.inputs.makes;
    };
  };
  configs = {
    src = cellsFrom + /${cellName}/configs;
  };
  devshellProfiles = {
    src = cellsFrom + /${cellName}/devshellProfiles;
    inputs.inputs = {
      inherit (inputs.std.inputs) devshell;
    };
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
