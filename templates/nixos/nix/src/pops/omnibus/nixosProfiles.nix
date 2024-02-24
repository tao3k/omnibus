# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.nixosProfiles.addLoadExtender { load = { }; }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    self: _super: {
      exports.customModules = self.outputs [
        {
          value = {
            enable = false;
            customList = with inputs.dmerge; append [ "1" ];
            imports = with inputs.dmerge; append [ ];
          };
          path = [
            "services"
            "openssh"
          ];
        }
      ];
    }
  ))
]
