{ lib }:

let
  # Recursive function to collect all attribute values
  recursiveAttrValues =
    set:
    lib.flatten (
      lib.mapAttrsToList
        (
          name: value:
          if lib.isAttrs value && !(lib.isFunction value) then
            recursiveAttrValues value
          else
            [ value ]
        )
        set
    );
in
recursiveAttrValues
