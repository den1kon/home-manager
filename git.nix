{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Denys Kondratiuk";
        email = "denyskondratiuk@check24.de";
      };
      init.defaultBranch = "main";
    };
  };
}
