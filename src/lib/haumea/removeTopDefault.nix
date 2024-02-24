# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

_: cursor: dir:
if (builtins.length cursor == 0 && (dir ? default)) then
  removeAttrs dir [ "default" ]
else
  dir
