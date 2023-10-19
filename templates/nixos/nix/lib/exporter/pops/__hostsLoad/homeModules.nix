{ root, inputs }:
name:
(root.exporter.pops.homeModules.addLoadExtender {
  load = {
    inputs = {
      inputs = inputs;
    };
  };
})
