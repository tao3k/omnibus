{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib;
  layouts = lib.pipe inputs.repo.lib.exporter.hosts [
    (lib.mapAttrs (_: v: v.layouts))
  ];
in
{
  example-darwin = layouts.darwin.hive;
}
