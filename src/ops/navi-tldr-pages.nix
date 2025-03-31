{
  inputs,
  lib,
}:
let
  inherit (inputs.self.flake.inputs) navi-tldr-pages nix-filter globset;
  inherit (inputs.nixpkgs.stdenv.hostPlatform) isLinux isDarwin;

  l = lib // builtins;
  root = navi-tldr-pages + /pages;
  src' = l.unsafeDiscardStringContext (toString root);
  # normalizedPaths = l.map (
  #   path:
  #   let
  #     path' = l.unsafeDiscardStringContext (toString path);
  #   in
  #   if l.hasPrefix l.storeDir path' then path' else src' + "/${path'}"
  # ) allowedPaths;
in
globset.lib.globs src' [
  "go.mod"
  "go.sum"
  "**/*.go"
]
# nix-filter.lib.filter {
#   inherit root;
#   exclude = [
#     "android"
#     "windows"
#     "sunos"
#     # (if isLinux then "osx" else "linux")
#     (
#       root: path: type:
#       if (l.match "[^/]*(rpm|yum|apt).*.cheat" (l.baseNameOf path)) == null then false else true
#     )
#   ]
#   # ++ l.optionals isDarwin [
#   #   # (root: path: type: if (l.match "[^/]*brew.*\.cheat" (l.baseNameOf path)) == null then false else true)
#   # ]
#   ;
# }
