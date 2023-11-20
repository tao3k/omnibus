# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
self:
lib.mapAttrs (_n: v: (if lib.isAttrs v then v else v { })) self
# (self.addLoadExtender {
#   load = {
#     transformer = [
#       (
#         cursor: mod:
#         let
#           trace = x: lib.trace x x;
#           toplevel = cursor == [ ];
#         in
#         if toplevel then
#           lib.mapAttrs (n: v: (if lib.isAttrs v then v else v { })) mod
#         else
#           mod
#       )
#     ];
#   };
# }).exports.default
