{ root }:
let
  load = root.pops.load;
in
loadCfg:
(load loadCfg).exports.default
