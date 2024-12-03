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

  dotfilesDir =
    "${homeDirectory}/${config.dots.emacs.directory}";

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
        rm -rf ${dotfilesDir}/*
        mkdir -p ${dotfilesDir}
        chown -R ${username}:users ${dotfilesDir}

        cp -rf ${fetchGit {
          url = "https://github.com/iErik/dots.emacs.git";
          exportIgnore = false;
          ref = "master";
          rev = "843d2ff276af46a316381f3730958e0252c6b308";
        }}/* ${dotfilesDir}

        find ${dotfilesDir} -type d -exec chmod 744 {} \;
        find  ${dotfilesDir} -type f -exec chmod 644 {} \;

        ln -s \
          ${dotfilesDir}/ \
          ${homeDirectory}/.config/emacs
      '');
  };
}
