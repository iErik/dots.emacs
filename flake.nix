{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default =
      (pkgs.callPackage ./nix/pkgs/emacs.nix { })
        .withPackages (epkgs: with epkgs; [
          treesit-grammars.with-all-grammars
        ]);

    homeManagerModules = {
      default = self.homeManagerModules.dots;
      dots = import ./nix/modules/hm.nix self;
    };
  };
}
