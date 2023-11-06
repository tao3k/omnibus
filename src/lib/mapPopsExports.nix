{ lib }:
pops:
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
let
  cond = (as: !(as ? "exports" && as.exports ? "default"));
  pops' = if !cond pops then pops.exports.default else pops;
in
lib.mapAttrsRecursiveCond cond (_: v: v.exports.default or v) pops'
