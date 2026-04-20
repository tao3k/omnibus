# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  flops = import (
    (fetchTarball {
      url = "https://github.com/${lock.nodes.flops.locked.owner}/${lock.nodes.flops.locked.repo}/archive/${lock.nodes.flops.locked.rev}.tar.gz";
      sha256 = lock.nodes.flops.locked.narHash;
    })
  );
in
flops.call-flake ./.
