(inputs.omnibus.pops.load {
  src = projectDir + "/units/nixos/hosts";
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  inputs = {
    inputs = inputs // root.pops.subflake.inputs;
    omnibus = inputs.omnibus // {
      self = root.omnibus.exports.default;
    };
  };
}).exports.default
