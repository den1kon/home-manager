{ config, pkgs, username, system, ... }:

let
  php = pkgs.php82.buildEnv {
    extensions = ({ enabled, all }: enabled ++ (with all; [
      xdebug
      imagick
      redis
      xsl
    ]));
    extraConfig = ''
      xdebug.mode=debug
    '';
  };

  homeDirectory = 
    if system == "aarch64-darwin" then
      "/Users/${username}"
    else
      "/home/${username}";

  isMacbook = system == "aarch64-darwin";
  isThinkpad = system == "x86_64-linux";
in

{
  # Home Manager configuration
  home.username = username;
  home.homeDirectory = homeDirectory;
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "25.11";

  # Universal packages for both systems
  home.packages = [
    pkgs.neovim
    pkgs.ripgrep
    pkgs.tmux
    pkgs.oh-my-zsh
    pkgs.imagemagick
    pkgs.redis
    pkgs.nodejs_24
    pkgs.adminer
    pkgs.lazygit
  ]
  # Macbook-specific packages
  ++ (if isMacbook then [
    pkgs.jetbrains.phpstorm
    pkgs.code-cursor
    pkgs.orbstack
    php
    (pkgs.php82Packages.composer.override {
      inherit php;
    })
  ] else [])
  # Thinkpad-specific packages
  ++ (if isThinkpad then [
    pkgs.spotify-player
  ] else []);

  home.file = {
    # Add file management here if needed
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
