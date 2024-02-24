# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super }:
{
  hostsDir,
  pops,
  addLoadExtender ? {
    load = { };
  },
}:
super.addLoadToPopsFilterBySrc hostsDir pops addLoadExtender
