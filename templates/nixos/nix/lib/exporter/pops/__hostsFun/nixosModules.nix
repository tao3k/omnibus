{ root, inputs }:
name:
(root.exporter.pops.nixosModules.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/nixos/hosts/${name}")
        "nixosModules";
    inputs = {
      inputs = inputs;
    };
  };
})
