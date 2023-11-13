{
  omnibus,
  lib,
  haumea,
}:
let
  inherit (omnibus) load;
in
{
  lua = lib.mapAttrs (_: builtins.unsafeDiscardStringContext) (
    load {
      src = ./__fixture;
      loader = with haumea; [
        (matchers.regex "^(.+)\\.(lua)$" (
          _: _: path:
          path
        ))
      ];
    }
  );
}
