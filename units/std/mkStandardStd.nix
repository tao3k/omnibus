{ inputs, super }:
let
  inherit (inputs) std;
  inherit (inputs.std) incl;

  l = inputs.nixpkgs.lib // builtins;
in
{
  projectRoot ? ./.,
  ...
}@args:
std.growOn (super.mkContent args)
