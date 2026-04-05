{
  config,
  pkgs,
  username,
  system,
  tree-sitter-cli,
  ...
}:

let
  php = pkgs.php82.buildEnv {
    extensions = (
      { enabled, all }:
      enabled
      ++ (with all; [
        xdebug
        imagick
        redis
        xsl
      ])
    );
    extraConfig = ''
      xdebug.mode=debug
    '';
  };

  homeDirectory = if system == "aarch64-darwin" then "/Users/${username}" else "/home/${username}";

  isMacbook = system == "aarch64-darwin";
  isThinkpad = system == "x86_64-linux";
  isLinux = isThinkpad;

  iosevkaTermNerdFont = pkgs.nerd-fonts.iosevka-term;

  fontsDir = if isMacbook then "Library/Fonts" else ".local/share/fonts";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";

  home.packages = [
    tree-sitter-cli
    pkgs.neovim
    pkgs.tmux
    pkgs.oh-my-zsh
    pkgs.imagemagick
    pkgs.redis
    pkgs.nodejs_24
    pkgs.adminer
    pkgs.lazygit

    pkgs.markdown-oxide
    pkgs.lua-language-server
    pkgs.typescript-language-server
    pkgs.stylua
    pkgs.nil
    pkgs.nixfmt
    pkgs.prettierd
    pkgs.jq
    pkgs.php82Packages.php-cs-fixer
    pkgs.phpactor
    pkgs.tinymist
    pkgs.typstyle

    pkgs.rustc
    pkgs.rustfmt
    pkgs.cargo

    pkgs.ripgrep
    pkgs.fd
    pkgs.bat
    pkgs.eza
    pkgs.zoxide

    iosevkaTermNerdFont
  ]
  ++ (
    if isMacbook then
      [
        pkgs.jetbrains.phpstorm
        pkgs.code-cursor
        pkgs.orbstack
        php
        (pkgs.php82Packages.composer.override { inherit php; })
      ]
    else
      [ ]
  )
  ++ (
    if isThinkpad then
      [
        pkgs.spotify-player
      ]
    else
      [ ]
  );

  home.file."${fontsDir}/NerdFonts".source = iosevkaTermNerdFont;

  fonts.fontconfig.enable = isLinux;

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
