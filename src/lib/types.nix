# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ yants, self }:
with yants; {
  suiteProfile = struct "profile" {
    keywords = list string;
    knowledges = list string;
    profiles = list any;
  };
}
