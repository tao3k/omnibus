{
  imports = [omnibus.homeModules.programs.foliate];
  programs.foliate = {
    enable = true;
    __profiles__.themes = {
      catppuccin-foliate = {
        enable = true;
      };
    };
  };
}
