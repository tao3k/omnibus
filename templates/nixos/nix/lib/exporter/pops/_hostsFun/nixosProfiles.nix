{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.loadNixOSProfiles.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
