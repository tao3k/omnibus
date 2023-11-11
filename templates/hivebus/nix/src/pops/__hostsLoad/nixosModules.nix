{ root, inputs }:
_name:
(root.pops.nixosModules.addLoadExtender {
  load = {
    inputs = { };
  };
})
