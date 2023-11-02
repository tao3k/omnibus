{ lib }:
pops:
let
in
# mapAttrsRecursiveCond' =
#   cond: f: set:
#   let
#     recurse =
#       path: set:
#       let
#         g =
#           name: value:
#           if lib.isAttrs value && cond value then
#             { ${name} = recurse (path ++ [ name ]) value; }
#           else
#             f (path ++ [ name ]) name value;
#       in
#       mapAttrs'' g set;
#   in
#   recurse [ ] set;
# mapAttrs'' =
#   f: set:
#   lib.foldl' (a: b: a // b) { } (
#     map (attr: f attr set.${attr}) (lib.attrNames set)
#   );
lib.mapAttrsRecursiveCond ((as: !(as ? "layouts" && as.layouts ? "default")))
  (_: v: v.exports.default or v)
  pops
