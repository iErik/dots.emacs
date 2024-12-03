{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default =
      pkgs.callPackage ./nix/pkgs/emacs.nix { };

    nixosModules.default = import ./nix/modules/nixos.nix;
    homeManagerModules.default =
      import ./nix/modules/hm.nix self;
  };
}
