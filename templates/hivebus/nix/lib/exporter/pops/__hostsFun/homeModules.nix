{ root, inputs }:
name:
(root.exporter.pops.homeModules.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/units/nixos/hosts/${name}")
        "homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
