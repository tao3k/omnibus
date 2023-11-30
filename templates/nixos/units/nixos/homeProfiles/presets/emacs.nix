# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  imports = [inputs.self.homeModules.programs.emacs];
  programs.emacs.__profiles__.test = "profile.test";
}
