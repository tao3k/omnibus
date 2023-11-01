{ root, inputs }:
name:
(root.pops.nixosModules.addLoadExtender {
  load = {
    inputs = { };
  };
})
