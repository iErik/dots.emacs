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

  cfg = config.dots.emacs;
  dotsDir = "${homeDirectory}/${cfg.directory}";
  xdgConfDir = "${homeDirectory}/.config/emacs";
  repoUrl = "git@github.com:iErik/dots.emacs.git";
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
        export PATH=${pkgs.openssh}/bin:$PATH
        export PATH=${pkgs.git}/bin:$PATH

	eval $(ssh-agent -s)
	ssh-add ${homeDirectory}/.ssh/id_25529

        rm -rf ${dotsDir}
        rm -rf ${xdgConfDir}

        git clone ${repoUrl} ${dotsDir}

        chown -R ${username}:users ${dotsDir}
        find ${dotsDir} -type d -exec chmod 744 {} \;
        find  ${dotsDir} -type f -exec chmod 644 {} \;

        ln -s ${dotsDir} ${xdgConfDir}

	ssh-agent -k
      '');
  };
}
