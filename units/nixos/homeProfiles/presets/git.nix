# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  programs.git = {
    enable = true;
    delta.enable = true;
    lfs.enable = true;

    extraConfig = {
      core.autocrlf = "input";
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autosquash = true;
      rerere.enabled = true;
    };
  };
}
