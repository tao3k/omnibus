let
  inherit (moduleArgs) pkgs;
  ordering = lib.concatStringsSep "," (
    (lib.optionals pkgs.stdenv.isDarwin [ "AppleSpell" ])
    ++ [
      # run `enchant-lsmod-2` to see the list of available dictionaries
      "aspell"
      "hunspell"
      "hspell"
    ]
  );
in
{
  home.file.".config/enchant/enenchant.ordering".source =
    pkgs.writeText "enenchant.ordering"
      ''
        *:${ordering}
        en_US:${ordering}
      '';
  home.packages = with pkgs; [
    (hunspellWithDicts [ hunspellDicts.en-us ])
    (aspellWithDicts (
      dicts:
      with dicts; [
        en
        en-computers
        en-science
      ]
    ))
  ];
}
