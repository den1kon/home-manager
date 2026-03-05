{ config, pkgs, ... }:

{
  home.programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
    bashrcExtra = ''
      complete -cf doas
    '';
  };
}
