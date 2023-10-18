{
  options = with lib; {
    lsp-bridge =
      mkEnableOption
        "Enable the language server protocol bridge support";
    emacs-eaf = mkEnableOption "Enable the Emacs Application Framework support";
    extraPackages = mkOption {
      type = types.functionTo (types.listOf types.package);
      default = ps: [ ];
      description = "The language server package to use";
    };
  };
}
