(inputs.omnibus.pops.exporter.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/hosts";
    inputs = {
      inputs = inputs // root.exporter.pops.subflake.inputs;
      omnibus = inputs.omnibus // {
        self = root.omnibus.lib.layouts.default;
      };
    };
  };
}).layouts.default
