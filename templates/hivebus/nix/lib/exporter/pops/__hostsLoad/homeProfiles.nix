{ root, inputs }:
(root.exporter.pops.homeProfiles.addLoadExtender {
  load = {
    inputs = {
      inputs = inputs;
    };
  };
})