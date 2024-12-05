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

  metaPkg = self.packages.${hostPlatform.system}.default;

  emacsPkg = (metaPkg.withPkgs (epkgs: with epkgs; [
    vterm
    treesit-grammars.with-all-grammars
    all-the-icons

    nix-ts-mode
    uxntal-mode
    slint-mode

    sublime-themes
    stimmung-themes
    soothe-theme

    rainbow-delimiters
    rainbow-identifiers
    rainbow-mode

    pkgs.rust-analyzer
    pkgs.rust-fmt
  ]));

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
      emacsPkg
    ];

    home.activation.emacsSetup = mkIf cfg.cloneConfig
      (entryAfter ["writeBoundary"] ''
        export PATH=${pkgs.openssh}/bin:$PATH
        export PATH=${pkgs.git}/bin:$PATH

	eval $(ssh-agent -s)
	ssh-add ${homeDirectory}/.ssh/id_ed25519

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
