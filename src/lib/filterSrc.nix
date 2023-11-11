{ lib, root }:
src:
let
  inherit (root.pops.flake.inputs) nix-filter;
in
nix-filter.lib.filter { root = src; }
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
