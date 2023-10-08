(
  {
    lib,
    config,
    options,
    ...
  }@args:
  {
    options = {
      __test__ = lib.mkOption {
        type = lib.types.attrs;
        default = { };
      };
    };
  }
)
