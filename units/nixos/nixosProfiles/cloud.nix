# [[file:../../../docs/org/nixosProfiles.org::*cloud][cloud:1]]
{
  root,
  omnibus,
  POP,
  flops,
}:
let
  srvosCustom =
    (omnibus.pops.srvos.addExporters [
      (POP.extendPop flops.haumea.pops.exporter (
        self: _super: {
          exports.srvosCustom = self.outputs [
            {
              value = { selfModule }: removeAttrs selfModule [ "imports" ];
              path = [
                "common"
                "default"
              ];
            }
          ];
        }
      ))
    ]).layouts.srvosCustom;
  presets = root.presets;
in
with presets; {
  default = [
    srvosCustom.common.default
    {
      boot.cleanTmpDir = true;
      boot.tmp.cleanOnBoot = true;
      zramSwap.enable = true;
      documentation.enable = false;
    }
  ];

  contabo = [
    self.default
    contabo
  ];
}
# cloud:1 ends here
