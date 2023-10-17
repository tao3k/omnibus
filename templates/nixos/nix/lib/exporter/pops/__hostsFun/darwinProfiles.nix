{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "darwinProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
