self: {
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib)
    mkEnableOption
    mkIf;

  cfg = config;
in {
  options = {
    enable = mkEnableOption "your mom is kinda hot";
  };

  config = mkIf cfg.enable {
    home.packages = [ ];

    pkgs.writeShellApplication {
      name: "test";
      runtimeInputs = [];
      text = ''
        echo "I am crazy"
      ''
    };
  };
}
