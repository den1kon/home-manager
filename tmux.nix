{ config, pkgs, ... }:
{
  # pkgs.tmux
  programs.tmux = {
    enable = true;
    clock24 = false;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.cpu
    ];
  };
}
