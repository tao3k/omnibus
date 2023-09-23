{
  options = with lib; {
    overlays = mkOption {
      type = types.lazyAttrsOf (
        types.uniq (
          types.functionTo (types.functionTo (types.lazyAttrsOf types.unspecified))
        )
      );
      apply = lib.mapAttrs (
        _k: f: final: prev:
        f final prev
      );
      default = { };
      example = lib.literalExpression or lib.literalExample ''
        {
          default = final: prev: {};
        }
      '';
    };
  };
}
