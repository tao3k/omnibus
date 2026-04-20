# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ yants, ... }:
with yants;
{
  /**
    Structured suite profile used by omnibus suite helpers.
  */
  suiteProfile = struct "profile" {
    keywords = list string;
    knowledges = list string;
    profiles = list any;
  };
}
