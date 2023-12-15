# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root, inputs }: (root.pops.nixosProfiles.addLoadExtender { load = { }; })
