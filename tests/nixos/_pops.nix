{
  omnibus,
  root,
  flops,
}:
(omnibus.pops.exporter.addLoadExtender {
  load = {
    src = ./__fixture;
    inputs = {
      data = root.data;
      inputs = {
        inherit (omnibus.flake.inputs) darwin nixpkgs home-manager;
      };
    };
  };
})
