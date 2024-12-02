{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      urls = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
  };

  outputs = { self, nixpkgs, neovim }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {

  };
}
