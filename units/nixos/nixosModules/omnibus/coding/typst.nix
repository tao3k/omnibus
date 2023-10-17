{
  options = with lib; {
    lsp = mkEnableOption (lib.mdDoc "Whether to enable languageServer support");
  };
}
