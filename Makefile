# Makefile for building NixOS image with specific command

# Default target
default: build

# Build target
build:
	nixos-generate -f raw -o output1 --flake .#molokoplus

.PHONY: build default

