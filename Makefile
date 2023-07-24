############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

test:
	doas nixos-rebuild --flake .#$(HOSTNAME) test

switch:
	doas nixos-rebuild --flake .#$(HOSTNAME) switch

list:
	doas nix-env --list-generations --profile /nix/var/nix/profiles/system

gc: 
	doas nix-collect-garbage -d
