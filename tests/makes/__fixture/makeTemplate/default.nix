# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  name = "example";
  template = makeTemplate {
    inherit name;
    replace = {
      __argBash__ = nixpkgs.bash;
      __argVersion__ = "1.0";
    };
    template = ''
      Bash is: __argBash__
      Version is: __argVersion__
    '';
  };
in
nixpkgs.writeTextFile {
  inherit name;
  executable = true;
  text = builtins.readFile "${template}/template";
}
