# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{lib}:
pops: load:
lib.mapAttrsRecursiveCond ((as: !(as ? "addLoadExtender")))
  (n: v: v.addLoadExtender (load n v))
  pops
