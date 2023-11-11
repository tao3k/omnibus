{ lib, super }:
dir: pops: load:
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
            ((v.addLoadExtender { inherit load; }).addLoadExtender {
              load.src = super.filterSrc src;
            })
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
