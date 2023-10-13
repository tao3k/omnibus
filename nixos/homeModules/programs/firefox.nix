{
  options.__profiles__ = with lib; {
    nurPkgs = mkOption {
      type = types.lazyAttrsOf types.raw;
      default = { };
    };
  };
}
