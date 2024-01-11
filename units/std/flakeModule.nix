{ inputs }:
{
  config,
  options,
  lib,
  ...
}:
let
  inherit (inputs) std;
  inherit (std.inputs) paisano;
  inherit (paisano) harvest pick winnow;

  inherit (builtins)
    head
    mapAttrs
    tail
    zipAttrsWith
    ;

  cfg = config.std;
  opt = options.std;
in
{
  imports = [ std.flakeModule ];
  options = {
    std.std = lib.mkOption {
      type = lib.mkOptionType {
        name = "std";
        description = "instanced std";
        check =
          v: (builtins.isAttrs v && v == { } || builtins.isAttrs v && v ? "__std");
      };
      apply = v: removeAttrs v [ "__functor" ];
      default = { };
    };
  };
  config = {
    flake =
      let
        grown = cfg.std;
        picked = mapAttrs (_: v: pick grown v) cfg.pick;
        harvested = mapAttrs (_: v: harvest grown v) cfg.harvest;
        winnowed = zipAttrsWith (_n: v: winnow (head v) grown (head (tail v))) [
          cfg.winnowIf
          cfg.winnow
        ];
      in
      lib.mkIf (opt.std.isDefined) (
        lib.foldl' lib.recursiveUpdate { } (
          [ config.std.std ]
          ++ (lib.optionals opt.pick.isDefined [ picked ])
          ++ (lib.optionals (opt.winnow.isDefined && opt.winnowIf.isDefined) [ winnowed ])
          ++ (lib.optionals opt.harvest.isDefined [ harvested ])
        )
      );
    # exposes the raw scheme of the std layout inside flake-parts
    perInput = system: flake: {
      cells = flake.${system} or { };
    };
  };
}
