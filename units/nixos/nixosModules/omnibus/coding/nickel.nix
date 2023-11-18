{
  options = with lib; {
    enableLsp = mkEnableOption (
      lib.mdDoc "Whether to enable languageServer support"
    );
  };
}
