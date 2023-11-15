{ lib, super }:
dir: pops: ext:
let
  list = lib.attrNames (lib.readDir dir);
  getDirs = host: lib.attrNames (lib.readDir (dir + "/${host}"));
  processPops =
    name:
    lib.filterAttrs (n: v: v != { }) (
      lib.mapAttrs
        (
          n: v:
          let
            dirs = getDirs name;
            src = (dir + "/${name}/${n}");
          in
          if (v ? addLoadExtender && (lib.pathExists src) && (lib.elem n dirs)) then
            if lib.isFunction ext then
              ext v
            else if lib.isAttrs ext then
              (v.addLoadExtender { load.src = src; }).addLoadExtender { load = ext; }
            else
              v
          else
            { }
        )
        pops
    );
in
lib.listToAttrs (
  map
    (name: {
      name = name;
      value = processPops name;
    })
    list
)
