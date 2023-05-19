{ config, lib, pkgs, user, ... }:

{
	home.stateVersion="22.11";
	programs.git = {
		enable = true;
		userName = "xuwei";
		userEmail = "franklxw@outlook.com";
	};
	programs.lazygit = {
		enable = true;
	};
	programs.starship = {
		enable = true;
		settings = {
		  add_newline = false;
		  format = lib.concatStrings [
		    "$line_break"
		    "$package"
		    "$line_break"
		    "$character"
		  ];
		  scan_timeout = 10;
		  character = {
		    success_symbol = "➜";
		    error_symbol = "➜";
		  };	
		  username = {
			style_user = "green bold"
			style_root = "black bold"
			format = "[$user]($style) "
			disabled = false
			show_always = true
		  };
		};
	};
}
