{ root, inputs }:
(root.pops.nixosModules.addLoadExtender {
  load = {
    inputs = {
      # only for host
      # custom = inputs.custom;
    };
  };
})
