# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  lib,
  stdenv,
  runtimeShell,
}:

stdenv.mkDerivation {
  pname = "example-unfree-package";
  version = "3.0";

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cat > $out/bin/hello-unfree << EOF
    #!${runtimeShell}
    echo "Hello, you are running an unfree system!"
    EOF
    chmod +x $out/bin/hello-unfree
  '';

  meta = {
    description = "An example package with unfree license (for testing)";
    maintainers = [ lib.maintainers.oxij ];
  };
}
