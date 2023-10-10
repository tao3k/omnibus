{
  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile (omnibus.dotfiles + "/dircolors/LS_COLORS");
  };
}
