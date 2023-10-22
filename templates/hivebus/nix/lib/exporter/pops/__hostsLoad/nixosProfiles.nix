{ root, inputs }:
(root.exporter.pops.nixosProfiles.addLoadExtender { load = { }; })
