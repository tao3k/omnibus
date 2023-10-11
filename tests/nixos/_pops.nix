{ omnibus, root }:
(omnibus.pops.exporter.addLoadExtender {
  load = {
    src = ./__fixture;
    inputs = {
      data = root.data;
      inputs = {
        inherit (omnibus.__inputs__) darwin nixpkgs;
      };
    };
  };
})
