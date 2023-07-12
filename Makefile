############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

vmware:
	doas nixos-rebuild --flake .#vmware test

minium:
	doas nixos-rebuild --flake .#minium test

list:
	doas nix-env --list-generations --profile /nix/var/nix/profiles/system

gc: 
	doas nix-collect-garbage -d
