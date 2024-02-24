# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
}
# {...}: {
#   boot = {
#     kernelParams = ["intel_iommu=on"];
#     kernelModules = ["vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" "irqbypass" "virtio"];
#     # PCI id's of graphics card
#     # extraModprobeConfig = ''
#     #   options vfio-pci ids=10de:1b80,10de:10f0
#     # '';
#   };
#   networking.interfaces.tap0 = {
#     virtualOwner = "guangtao";
#     virtual = true;
#     virtualType = "tap";
#     useDHCP = true;
#   };
#   environment.etc."qemu/bridge.conf".text = "allow br0";
# }
