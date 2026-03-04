{ lib, pkgs, ... }:
let
  username = "dk";
in
{
  home = {
    packages = with pkgs; [ ];

    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    file = {
      ".bashrc" = {
        text = ''
          								# This must be sourced in your .bashrc or whatever shell you're using.
          								# In the future we can get home-manager to do this for us, but bootstrapping for now...
          								source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
          								alias ls = eza
          								complete -cf doas
        '';
        executable = false;
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
    bashrcExtra = ''
      complete -cf doas
    '';
  };

  programs.firefox = {
    enable = true;
  };
}
