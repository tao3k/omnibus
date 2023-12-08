{lib, super}:
attrs:
lib.mapAttrs
  (_: v: if lib.isList v then lib.flatten (super.concatProfiles v) else v)
  attrs
