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
        "darwinModules";
    inputs = {
      inputs = inputs;
    };
  };
})
