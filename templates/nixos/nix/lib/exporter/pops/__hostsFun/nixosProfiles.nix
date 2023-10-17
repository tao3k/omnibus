{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
