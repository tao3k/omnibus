{
  programs.direnv = {
    enable = true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    enableFishIntegration = lib.mkIf config.programs.fish.enable true;
    enableBashIntegration = lib.mkIf config.programs.bash.enable true;
    nix-direnv = {
      enable = true;
    };
  };
}
