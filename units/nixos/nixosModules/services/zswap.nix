# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config,
  lib,
  pkgs,
  ...
}:
# credit: https://github.com/linyinfeng/dotfiles/blob/53b14c9447a84f17d916ddd580375ec2ae8232ce/nixos/modules/services/zswap.nix#L9
let
  cfg = config.services.zswap;

  zswapSetup = pkgs.writeShellApplication {
    name = "zswap-setup";
    text = ''
      action="$1"

      case "$action" in
      up)
        echo ${cfg.compressor}              | tee /sys/module/zswap/parameters/compressor
        echo ${cfg.zpool}                   | tee /sys/module/zswap/parameters/zpool
        echo ${toString cfg.maxPoolPercent} | tee /sys/module/zswap/parameters/max_pool_percent

        echo Y | tee /sys/module/zswap/parameters/enabled
        grep -r . /sys/module/zswap/parameters
        ;;

      down)
        echo N | tee /sys/module/zswap/parameters/enabled
        grep -r . /sys/module/zswap/parameters
        ;;

      *)
        grep -r . /sys/module/zswap/parameters
        ;;

      esac
    '';
  };
in
{
  options = {
    enable = lib.mkEnableOption "zswap";
    compressor = lib.mkOption {
      type = with lib.types; str;
      default = "zstd";
    };
    zpool = lib.mkOption {
      type = with lib.types; str;
      default = "zsmalloc";
    };
    maxPoolPercent = lib.mkOption {
      type = with lib.types; int;
      default = 20;
    };
  };

  config =
    with lib;
    mkMerge [
      (lib.mkIf cfg.enable {
        assertions = [
          {
            assertion = !(cfg.enable && config.zramSwap.enable);
            message = "zswap and zram based swap should not be enabled at the same time";
          }
        ];
        systemd.services.zswap = {
          serviceConfig = {
            ExecStart = "${lib.getExe zswapSetup} up";
            ExecStop = "${lib.getExe zswapSetup} down";
            Type = "oneshot";
            RemainAfterExit = true;
          };
          wantedBy = [ "multi-user.target" ];
        };
      })
      (lib.mkIf (cfg.enable && cfg.zpool == "zsmalloc") {
        boot.initrd.availableKernelModules = [ "zsmalloc" ];
      })
      (lib.mkIf (cfg.enable && cfg.zpool == "z3fold") {
        services.zswap.compressor = "lz4";
        boot.initrd.availableKernelModules = [
          "lz4"
          "z3fold"
        ];
      })
    ];
}
