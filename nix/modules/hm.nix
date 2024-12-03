self: {
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf types;
  inherit (lib.hm.dag) entryAfter;

  inherit (pkgs.stdenv) hostPlatform;

  inherit (config.home) username homeDirectory;

  dotfilesDir = "${homeDirectory}/${config.directory}";
  cfg = config.dots.emacs;
in {
  options.dots.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Emacs Dotfiles module";
    };

    cloneConfig = mkOption {
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

    home.activation.emacsSetup = mkIf cfg.cloneConfig
      (entryAfter ["writeBoundary"] ''
        mkdir -p ${homeDirectory}/${cfg.directory}
        rm -rf ${homeDirectory}/${cfg.directory}/{*,.*}

        cp -r ${fetchGit {
          url = "git@github.com:iErik/dots.emacs.git";
          ref = "master";
        }}/* ${homeDirectory}/${cfg.directory}

        chown -R ${username}:users 
        ln -s \
          ${homeDirectory}/${cfg.directory}/ \
          ${homeDirectory}/.configs/emacs.d
      '');
  };
}
