{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    haumea.follows = "omnibus/flops/haumea";
    flops.follows = "omnibus/flops";
  };

  outputs =
    { self, ... }@inputs:
    let
      eachSystem = inputs.flops.inputs.nixlib.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      library = import ./nix/lib/__init.nix { inherit inputs eachSystem; };
      lib = library.exports.default;
    in
    lib.flakeOutputs
    // {
      inherit lib;
      pops = lib.pops;
    };
}
