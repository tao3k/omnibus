{ lib, root }:
src: dir:
let
  inherit (root.pops.subflake.inputs) nix-filter;
  popsDirs = lib.attrNames (
    lib.removeAttrs root.pops [
      "hosts"
      "omnibus"
    ]
  );
in
# include =
#   let
#     srcDirs = lib.attrNames (lib.readDir src);
#     popsDirs = lib.attrNames (
#       lib.removeAttrs root.pops [
#         "hosts"
#         "omnibus"
#       ]
#     );
#   in
#   lib.concatMap
#     (
#       dir:
#       let
#         list =
#           assert lib.assertMsg
#               (if lib.lists.intersectLists dirs popsDirs != [ ] then true else false)
#               ''
#                 The directory ${dir} is not a valid pops directory.
#                 Please check the pops attribute in the root exporter.
#               '';
#           map (x: "${x}") dirs;
#       in
#       list
#     )
#     srcDirs;
nix-filter.lib.filter { root = src + "/${dir}"; }
