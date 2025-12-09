{
	description = "My Home Manager configuration";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager/releases-25.05";
		};
	};

	outputs = { nixpkgs, home-manager, ... }:
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = import nixpkgs { inherit  system; };
		in {
			homeConfigurations = {
				dk = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./home.nix ];
				};
			};
		};
}
