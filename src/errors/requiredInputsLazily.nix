{ super, lib }:
inputs: pop: listInputs:
let
  getRequiredInput = key: (super.requiredInputs inputs "test" [ key ]).${key};
in
lib.genAttrs listInputs (name: getRequiredInput name)
