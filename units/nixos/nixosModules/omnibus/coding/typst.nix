# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  options = with lib; {
    enableLsp = mkEnableOption (
      lib.mdDoc "Whether to enable languageServer support"
    );
  };
}
