{ omnibus }:
let
  system = "x86_64-linux";
  loadedInputs =
    ((omnibus.pops.flake.setInitInputs ./__lock).setSystem system).inputs;
  jupyenvModules = omnibus.pops.jupyenv {
    src = ./__fixture;
    inputs = {
      inputs = {
        inherit (loadedInputs) jupyenv nixpkgs;
      };
    };
  };
in
{
  jupyenvEvalModulesExampleBashKernel =
    jupyenvModules.exports.jupyenvEvalModules.example.config.kernel.bash.omnibus.displayName;
  jupyenvModulesExampleEnv = jupyenvModules.exports.jupyenvEnv.example;
  jupyenvModules = jupyenvModules.exports.default;
}
