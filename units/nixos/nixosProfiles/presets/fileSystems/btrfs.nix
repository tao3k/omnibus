# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  # protect data integrity
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
}
