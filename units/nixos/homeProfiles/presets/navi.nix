{ config, lib, ... }:
let
  l = lib // builtins;
in
{
  programs.navi = {
    enable = true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    settings = {
      cheats = {
        # paths =
        #   [];
        # (src: (map (x: src + "/${x}") (l.attrNames (l.readDir src))))
        #   inputs.cells.nixos.data.navi-tldr-pages;
      };
    };
  };
}
