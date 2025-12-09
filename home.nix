{ lib, pkgs, ... }:
{
	home = {
		packages = with pkgs; [
			hello
			cowsay lolcat
		];

		username = "dk";
		homeDirectory = "/home/dk";

		stateVersion = "25.05";
	};
}
