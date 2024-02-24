# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ config, ... }:
{
  privateKeyFile = "${config.users.users.${user}.home}/${path}";
  publicKeyFile = "${config.users.users.${user}.home}/${path}";
}
