{
  options.__profiles__ = with lib; {
    test = mkOption {
      type = types.str;
      default = "test";
    };
  };
}
