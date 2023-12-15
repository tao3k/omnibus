# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  lib,
  stdenv,
  runtimeShell,
  __inputs__,
}:

stdenv.mkDerivation {
  pname = "example-unfree-package";
  version = "2.0";

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cat > $out/bin/hello-unfree << EOF
    #!${runtimeShell}
    echo "Hello, you are running an unfree system!"
    EOF
    chmod +x $out/bin/hello-unfree
  '';

  passthru = {
    test = __inputs__;
  };
  meta = {
    description = "An example package with unfree license (for testing)";
    maintainers = [ lib.maintainers.oxij ];
  };
}
