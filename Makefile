default: build
format:
	nixfmt -v $(find . -name '*.nix')
build: 
	nixos-generate -f raw -o output --flake .#molokoplus
.PHONY: build default format
