{
  description = "A very basic flake";

  inputs.call-flake.url = "github:divnix/call-flake";

  outputs =
    {self, call-flake}:
    let
      local = call-flake ../.;
      inherit (local) examples;
    in
    {
      packages.x86_64-linux = examples.packages.exports.derivations;
    };
}
