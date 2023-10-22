{ root, inputs }:
(root.exporter.pops.nixosModules.addLoadExtender {
  load = {
    inputs = {
      # only for host
      # custom = inputs.custom;
    };
  };
})
