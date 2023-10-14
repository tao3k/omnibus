{
  omnibus,
  root,
  inputs,
}:
name:
(omnibus.pops.loadHomeModules.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
