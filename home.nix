{ lib, pkgs, ... }:
{
	home = {
		packages = with pkgs; [
			hello
		];

		username = "dk";
		homeDirectory = "/home/dk";

		stateVersion = "25.05";
	}
}
