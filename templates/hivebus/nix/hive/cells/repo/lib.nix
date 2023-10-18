{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  __inputs__ = (inputs.repo.flake.setSystem nixpkgs.system).inputs;
in
{
  inherit __inputs__;
}
