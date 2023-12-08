{lib}:
let
  inherit (lib.types) suiteProfile;
  v = x: if lib.isAttrs x then (lib.types.suiteProfile x).profiles else x;
in
lib.concatMap (x: [(v x)])
