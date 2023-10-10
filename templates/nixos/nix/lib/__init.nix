{ inputs, eachSystem }:
(inputs.omnibus.pops.exporter.addLoadExtender {
  load = {
    src = ./.;
    inputs = {
      inherit inputs eachSystem;
    };
  };
})
