{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
