{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (inputs.omnibus.inputs.flops.inputs.nixlib) lib;
      eachSystem = lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      library = import ./nix/lib/__init.nix { inherit inputs eachSystem; };
      libraryOutputs = library.exports.default;
    in
    libraryOutputs.flakeOutputs
    // {
      lib = libraryOutputs;
      pops = libraryOutputs.pops;
    };
}
