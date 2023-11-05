(inputs.omnibus.pops.load {
  src = inputs.self.outPath + "/units/nixos/hosts";
  inputs = {
    inputs = inputs // root.pops.subflake.inputs;
    omnibus = inputs.omnibus // {
      self = root.omnibus.exports.default;
    };
  };
}).exports.default
