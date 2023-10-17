{ config, lib, ... }:
{
  config =
    with lib;
    mkMerge [ {
      services.greetd = {
        enable = true;
      };
    } ];
}
