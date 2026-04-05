{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = { nixpkgs, home-manager, textfox, ... }:
    let
      # Define configurations for different machines
      configs = {
        macbook = {
          system = "aarch64-darwin";
          username = "denyskondratiuk";
          modules = [
            textfox.homeManagerModules.default
            ./home.nix
            ./git.nix
            ./firefox.nix
            ./alacritty.nix
          ];
        };
        thinkpad = {
          system = "x86_64-linux";
          username = "dk";
          modules = [
            textfox.homeManagerModules.default
            ./home.nix
            ./bash.nix
            ./firefox.nix
            ./gtk.nix
            ./delta.nix
          ];
        };
      };

      mkHomeConfig = name: config:
        let
          pkgs = nixpkgs.legacyPackages.${config.system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = config.modules;
          extraSpecialArgs = {
            inherit (config) system username;
          };
        };
    in
    {
      homeConfigurations = builtins.mapAttrs mkHomeConfig configs;
    };
}
