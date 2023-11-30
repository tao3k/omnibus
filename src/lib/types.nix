# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{yants, self}:
with yants; {
  a = struct "test" {name = string;};
  b = either self.a (struct {age = int;});
}
