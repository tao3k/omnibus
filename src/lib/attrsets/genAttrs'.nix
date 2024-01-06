{ ... }: values: f: builtins.listToAttrs (map f values)
