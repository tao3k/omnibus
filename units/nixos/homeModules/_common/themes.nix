{ lib, inputs }:
with lib; {
  themes = mkOption {
    default = { };
    type = types.attrsOf (
      types.submodule (
        {
          config,
          options,
          name,
          ...
        }:
        {
          options = {
            enable = mkEnableOption (
              lib.mdDoc "Whether to enable ${name}-catppuccin theme"
            );
            src = mkOption {
              type = types.str;
              default = "";
              description = "The package to use for ${name}-catppuccin theme";
            };
          };
          config = mkMerge [
            (mkIf (hasAttr name inputs) { src = inputs.${name}.outPath or inputs.${name}; })
          ];
        }
      )
    );
  };
}
