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
/**
  Attach host-specific `load.src` selectors for every pop directory found under
  `hostsDir`.
*/
super.addLoadToPopsFilterBySrc hostsDir pops addLoadExtender
