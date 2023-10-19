{ root, inputs }:
(root.exporter.pops.nixosModules.addLoadExtender {
  load = {
    inputs = {
      inputs = inputs;
    };
  };
})
