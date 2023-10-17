{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.homeModules.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
