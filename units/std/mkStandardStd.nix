{ inputs, super }:
let
  inherit (inputs) std;
in
{ ... }@args:
std.growOn (super.mkContent args)
