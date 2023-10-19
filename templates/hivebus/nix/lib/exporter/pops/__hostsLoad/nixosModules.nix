{ root, inputs }:
name:
(root.exporter.pops.nixosModules.addLoadExtender {
  load = {
    inputs = {
      inputs = inputs;
    };
  };
})
