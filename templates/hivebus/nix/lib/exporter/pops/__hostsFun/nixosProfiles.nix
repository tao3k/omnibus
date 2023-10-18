{ root, inputs }:
name:
(root.exporter.pops.nixosProfiles.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/units/nixos/hosts/${name}")
        "nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
