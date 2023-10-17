{ pkgs, lib, ... }:
{
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
    };
    inputMethod.fcitx5 = {
      # fcitx.engines = with pkgs.fcitx-engines; [cloudpinyin rime];
      addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-rime
      ];
    };
  };
  environment = lib.mkMerge [ { variables = { }; } ];
}
