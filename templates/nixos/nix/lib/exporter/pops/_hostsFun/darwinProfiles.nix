{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.loadNixOSModules.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "darwinProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
