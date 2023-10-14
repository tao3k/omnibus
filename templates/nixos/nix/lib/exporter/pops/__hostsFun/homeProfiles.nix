{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.loadHomeProfiles.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
