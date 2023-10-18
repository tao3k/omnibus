{ root, inputs }:
name:
(root.exporter.pops.homeProfiles.addLoadExtender {
  load = {
    src =
      root.filterPopsSrc (inputs.self.outPath + "/units/nixos/hosts/${name}")
        "homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
