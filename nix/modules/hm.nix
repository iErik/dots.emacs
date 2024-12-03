self: {
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf types;

  inherit (pkgs.stdenv) hostPlatform;

  inherit (config.home) username homeDirectory;

  dotfilesDir = "${homeDirectory}/${config.directory}";
  cfg = config;
in {
  options = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Emacs Dotfiles module";
    };

    cloneConfigs = mkOption {
      type = types.bool;
      default = true;
      description =
        "Whether or not to clone the Dotfiles" +
        "repository to the user's directory";
    };

    directory = mkOption {
      type = types.str;
      default = "Dots/Emacs.dot";
      description =
        "The path of the directory in which to " +
        "store the dotfiles (relative to the " +
        "user's home directory).";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      self.packages.${hostPlatform.system}.default
    ];

    system.userActivationScripts.emacsSetup =
      mkIf cfg.cloneConfigs {
        text = ''
          mkdir -p ${homeDirectory}/${cfg.directory}

          cp -r ${pkgs.fetchFromGithub {
            owner = "iErik";
            repo = "dots.emacs";
          }}/* ${homeDirectory}/${cfg.directory}

          chown -R ${username}:users 
        '';
      };
  };
}
