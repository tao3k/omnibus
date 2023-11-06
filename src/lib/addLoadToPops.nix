{ lib }:
list: pops: load:
lib.listToAttrs (
  map
    (name: {
      inherit name;
      value =
        lib.mapAttrs
          (n: v: if v ? addLoadExtender then v.addLoadExtender (load name n v) else v)
          pops;
    })
    list
)
