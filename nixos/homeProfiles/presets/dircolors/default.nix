{
  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile (dotfiles + "/dircolors/LS_COLORS");
  };
}
