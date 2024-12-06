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
    pkgs.libvterm
    vterm
    # Broken :(
    #eterm-256color
    flycheck
    treesit-grammars.with-all-grammars
    all-the-icons
    magit
    helm

    dirvish
    pkgs.fd
    pkgs.poppler
    pkgs.ffmpegthumbnailer
    pkgs.mediainfo

    rainbow-delimiters
    rainbow-identifiers
    rainbow-mode

    nix-ts-mode
    nix-mode
    uxntal-mode
    slint-mode

    select-themes
    sublime-themes
    stimmung-themes
    soothe-theme
    kanagawa-themes
    kuronami-theme
    timu-spacegrey-theme
    timu-rouge-theme
    timu-macos-theme
    timu-line
    timu-caribbean-theme
    exotica-theme
    inkpot-theme
    arjen-grey-theme
    avk-emacs-themes
    badger-theme
    base16-theme
    boron-theme
    bubbleberry-theme
    challenger-deep-theme
    caroline-theme
    klere-theme
    laguna-theme
    ample-theme
    ample-zen-theme
    catppuccin-theme
    gruvbox-theme
    sweetgreen
    organic-green-theme
    green-phosphor-theme
    ef-themes
    sakura-theme

    pkgs.rust-analyzer
    pkgs.rustfmt
    pkgs.ols
    pkgs.vim-language-server
    pkgs.vue-language-server
    pkgs.cmake-language-server
    pkgs.yaml-language-server
    pkgs.vala-language-server
    pkgs.bash-language-server
    pkgs.elmPackages.elm-language-server
    pkgs.zls
    pkgs.gopls
    pkgs.hyprls
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

    useSsh = mkOption {
      type = types.bool;
      default = true;
      description =
	"Whether to use SSH to fetch git repository";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [emacsPkg];

    home.activation.emacsSetup = mkIf cfg.cloneConfig
      (entryAfter ["writeBoundary"] ''
        export PATH=${pkgs.openssh}/bin:$PATH
        export PATH=${pkgs.git}/bin:$PATH

        eval $(ssh-agent -s)
        ssh-add

        if [ -d "${dotsDir}/.git" ];
        then
          cd ${dotsDir} && git pull origin master
        else
          rm -rf ${dotsDir}
          rm -rf ${xdgConfDir}

          git clone ${repoUrl} ${dotsDir}

          chown -R ${username}:users ${dotsDir}
          find ${dotsDir} -type d -exec chmod 744 {} \;
          find  ${dotsDir} -type f -exec chmod 644 {} \;

          ln -s ${dotsDir} ${xdgConfDir}
        fi

        ssh-agent -k
      '');
  };
}
