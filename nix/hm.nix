{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf;

  cfg = config;
in
{
  options = {
    enable =  mkEnableOption "your mom is kinda hot";
  };

  config = mkIf cfg.enable {
    home.packages = [ ];
  };
}
