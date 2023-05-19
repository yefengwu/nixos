{ config, lib, pkgs, user, ... }:

{
	home.stateVersion="22.11";
	programs.git = {
		enable = true;
		userName = "xuwei";
		userEmail = "franklxw@outlook.com";
	};
}
