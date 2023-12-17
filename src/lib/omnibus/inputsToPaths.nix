# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, flops }:
# let
#   # Helper function to collect outPath attributes recursively
#   collectPaths =
#     input:
#     lib.concatMap
#       (
#         attr:
#         let
#           # Check for outPath or sourceInfo.outPath and collect if present
#           paths =
#             if lib.isAttrs attr then
#               if attr ? outPath then
#                 [ attr.outPath ]
#               else if attr ? sourceInfo && attr.sourceInfo ? outPath then
#                 [ attr.sourceInfo.outPath ]
#               else
#                 [ ]
#             else
#               [ ];
#           # Recursively collect paths from nested inputs if they exist
#           nestedPaths =
#             if lib.isAttrs attr && attr ? inputs then collectPaths attr.inputs else [ ];
#         in
#         paths ++ nestedPaths
#       )
#       (lib.attrValues input);
#   # Main function to collect outPath attributes from all inputs
#   inputsToPaths = inputs: lib.flatten (collectPaths inputs);
# in
# # Example usage
# inputsToPaths
inputs:
let
  l = lib;

  getTopLevelPath =
    pathString:
    let
      # Split the path into parts
      parts = lib.splitString "/" pathString;
      # Take the first four parts which constitute the Nix store path
      # and the hash with the source name
      topLevelParts = lib.take 4 parts;
    in
    # Recombine the parts back into a string path
    if l.length parts > 4 then
      lib.concatStringsSep "/" topLevelParts
    else
      pathString;

  extractAttrsFromInputs =
    inputs:
    l.pipe inputs [
      (l.filterAttrs (_: v: l.isAttrs v && (v ? sourceInfo.outPath || v ? outPath)))
      (l.mapAttrs (_: v: v.sourceInfo.outPath or v.outPath or v.path))
      (l.mapAttrs (_: v: getTopLevelPath (toString v)))
    ];

  attrsToPaths = i: lib.attrValues (extractAttrsFromInputs i);

  inherit (flops) recursiveMerge;
  updatedInputs = (recursiveMerge (l.flatten [ inputs ]));
in
l.pipe updatedInputs [
  (
    v:
    map (x: if v.${x} ? inputs then attrsToPaths v.${x}.inputs else attrsToPaths v)
      (l.attrNames (extractAttrsFromInputs v))
  )
  l.flatten
  l.unique
]
++ attrsToPaths updatedInputs # extractPaths From the top level inputs
/* inputsToPaths {
     b = {
       inputs = {
         d = {
           outPath = "<PATH-b.d>";
         };
         f = {
           outPath = "<PATH-b.f>";
         };
       };
       outPath = "<PATH-b>";
     };
     a = {
       inputs = {
         b = {
           outPath = "<PATH-a.b>";
         };
         c = {
           outPath = "<PATH-a.c>";
         };
       };
       outPath = "<PATH-a>";
     };
   }
   =>
   [ "<PATH-a>" "<PATH-a.b>" "<PATH-a.c>" "<PATH-b>" "<PATH-b.d>" "<PATH-b.f>" ]
*/
