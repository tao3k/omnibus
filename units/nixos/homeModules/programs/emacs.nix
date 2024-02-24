# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  treeSitterPlugins = cfg.__profiles__.treeSitterPlugins;
  lib' =
    drv:
    let
      libName = drv: pkgs.lib.removeSuffix "-grammar" drv.pname;
      libSuffix = if pkgs.stdenv.isDarwin then "dylib" else "so";
    in
    "lib${libName drv}.${libSuffix}";

  linkCmd =
    drv:
    if pkgs.stdenv.isDarwin then
      ''
        cp ${drv}/parser .
        chmod +w ./parser
        install_name_tool -id $out/lib/${lib' drv} ./parser
        cp ./parser $out/lib/${lib' drv}
        ${pkgs.darwin.sigtool}/bin/codesign -s - -f $out/lib/${lib' drv}
      ''
    else
      "ln -s ${drv}/parser $out/lib/${lib' drv}";

  tree-sitter-grammars = pkgs.runCommandCC "tree-sitter-grammars" { } (
    lib.concatStringsSep "\n" (
      [ "mkdir -p $out/lib" ] ++ (map linkCmd treeSitterPlugins)
    )
  );
in
{
  options.__profiles__ = with lib; {
    treeSitterPlugins = mkOption {
      type = types.listOf types.package;
      default = [ ];
    };
  };
  config =
    with lib;
    mkMerge [
      (mkIf (treeSitterPlugins != [ ]) {
        home.activation.linkEmacsTreeSitter =
          config.lib.dag.entryAfter [ "writeBoundary" ]
            ''
              ln -sfT ${tree-sitter-grammars}/lib $HOME/.emacs.d/.local/cache/tree-sitter
            '';
      })
    ];
}
