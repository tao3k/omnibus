(flops.haumea.pops.default.setInit {
  src = projectDir + "/units/nixos/homeModules";
  type = "nixosModules";
  inputs = root.lib.loaderInputs;
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports = {
          exportModulesRecursive = lib.recursiveAttrValues self.layouts.default;
        };
      }
    ))
  ]
