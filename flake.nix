{
  description = "Home Manager configuration of dk";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";

    # Firefox nightly
    # TODO: remove when stable reaches version 149
    # firefox.url = "github:nix-community/flake-firefox-nightly";
    # firefox.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      textfox,
      # firefox, # TODO remove
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."dk" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          textfox.homeManagerModules.default
          ./home.nix
          ./bash.nix
          ./firefox.nix
          ./gtk.nix
          ./delta.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        # extraSpecialArgs = {
        #   inherit firefox;
        # };
      };
    };
}
