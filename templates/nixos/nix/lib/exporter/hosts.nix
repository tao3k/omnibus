(inputs.omnibus.pops.exporter.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/hosts";
    inputs = {
      inputs = inputs // root.exporter.pops.flake.inputs;
      omnibus = inputs.omnibus // {
        self = root.omnibus.lib.layouts.default;
      };
    };
  };
}).layouts.default
