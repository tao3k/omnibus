{
  imports = [ inputs.self.homeModules.programs.emacs ];
  programs.emacs.__profiles__.test = "profile.test";
}
