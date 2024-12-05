{
  pkgs,
  lib,
  stdenv,

  substituteAll,
  fetchzip,
  emacsPackagesFor,

  ...
}: let
  libGccJitLibraryPaths = [
    "${lib.getLib pkgs.libgccjit}/lib/gcc"
    "${lib.getLib stdenv.cc.libc}/lib"
  ] ++ lib.optionals (stdenv.cc?cc.lib.libgcc) [
    "${lib.getLib stdenv.cc.cc.lib.libgcc}/lib"
  ];

  version = "29.4";
  siteStart = ./site-start.el;
in stdenv.mkDerivation (finalAttrs: {
  pname = "emacs";
  inherit version;

  src = fetchzip {
    url =
      "https://ftp.gnu.org/gnu/emacs/emacs-${version}.tar.gz";
    sha256 =
      "06d2qia2pflsigjkkivjma9cvmc1qjdk4sn5lzlawxjng9icb257";
  };

  nativeBuildInputs = [
    pkgs.makeWrapper
    pkgs.wrapGAppsHook3

    pkgs.libgcc
    pkgs.binutils
    pkgs.gmp
    pkgs.sqlite
    pkgs.pkg-config
    pkgs.lndir
  ];

  buildInputs = [
    pkgs.gnutls
    pkgs.gettext
    (lib.getDev pkgs.harfbuzz)
    pkgs.jansson

    pkgs.acl
    pkgs.alsa-lib
    pkgs.gpm
    pkgs.dbus
    pkgs.gsettings-desktop-schemas
    pkgs.libotf
    pkgs.glib-networking

    pkgs.libgccjit
    pkgs.imagemagick
    pkgs.sqlite
    pkgs.systemd

    pkgs.xorg.libXaw
    pkgs.zlib
    pkgs.libpng
    pkgs.libjpeg
    pkgs.libtiff
    pkgs.librsvg
    pkgs.libwebp
    pkgs.texinfo
    pkgs.ncurses

    pkgs.giflib
    pkgs.gtk3
    pkgs.gtk3-x11
    pkgs.xorg.libXpm

    pkgs.tree-sitter
    pkgs.cairo

    pkgs.webkitgtk_4_0
  ];

  dontConfigure = false;

  configureFlags = [
    "--with-pgtk"
    "--with-native-compilation=yes"
    "--with-imagemagick"
    "--with-cairo"
    "--with-modules" # For dynamic C Modules
    "--with-json"
    "--with-tree-sitter"
    "--with-small-ja-dic"
    "--with-xwidgets"
    "--with-x-toolkit=gtk"
    "--with-mailutils"
    "--enable-link-time-optimization"
  ];

  patches = [
    (substituteAll {
      src = ./patches/native-comp-driver.patch;

      backendPath = (lib.concatStringsSep " "
        (builtins.map (x: ''"-B${x}"'') ([
          # Paths necessary so the JIT compiler finds
          # its libraries:
          "${lib.getLib pkgs.libgccjit}/lib"
        ] ++ libGccJitLibraryPaths ++ [
          # Executable paths necessary for
          # compilation (ld, as):
          "${lib.getBin stdenv.cc.cc}/bin"
          "${lib.getBin stdenv.cc.bintools}/bin"
          "${lib.getBin stdenv.cc.bintools.bintools}/bin"
        ])));
     })
  ];

  postPatch = lib.concatStringsSep "\n" [

    # Add the name of the wrapped gvfsd
    (lib.concatStrings (map (fn:
      ''
      sed -i 's#(${fn} \
      "gvfs-fuse-daemon")#(${fn} "gvfs-fuse-daemon") \
      (${fn} ".gvfsd-fuse-wrapped")#' lisp/net/tramp-gvfs.el
      '') [
      "tramp-compat-process-running-p"
      "tramp-process-running-p"
    ]))

    # Reduce closure size by cleaning the environment
    # of the emacs dumper
    ''
      substituteInPlace src/Makefile.in \
        --replace 'RUN_TEMACS = ./temacs' \
        'RUN_TEMACS = env -i ./temacs'
    ''

    ''
      substituteInPlace lisp/international/mule-cmds.el \
        --replace /usr/share/locale ${pkgs.gettext}/share/locale

      for makefile_in in $(find . -name Makefile.in -print); do
        substituteInPlace $makefile_in --replace /bin/pwd pwd
      done
    ''

    ""
  ];

  postInstall = ''
    mkdir -p $out/share/emacs/site-lisp
    mkdir -p $out/share/emacs/native-lisp
    mkdir -p $out/lib

    cp ${siteStart} $out/share/emacs/site-lisp/site-start.el
    $out/bin/emacs --batch -f batch-byte-compile \
      $out/share/emacs/site-lisp/site-start.el


    echo "Generating native-compiled trampolines..."
    # precompile trampolines in parallel, but avoid
    # spawning one process per trampoline. 1000 is a rough
    # lower bound on the number of trampolines compiled.
    $out/bin/emacs --batch --eval                    \
      "(mapatoms (lambda (s)                         \
        (when (subr-primitive-p (symbol-function s)) \
            (print s))))"                            \
      | xargs -n $((1000/NIX_BUILD_CORES + 1))       \
              -P $NIX_BUILD_CORES                    \
      $out/bin/emacs --batch -l comp --eval          \
        "(while argv (comp-trampoline-compile        \
          (intern (pop argv))))"

    $out/bin/emacs --batch                            \
      --eval "(add-to-list 'native-comp-eln-load-path \
            \"$out/share/emacs/native-lisp\")"        \
      -f batch-native-compile                         \
         $out/share/emacs/site-lisp/site-start.el

    linkPath() {
      local pkg=$1
      local origin_path=$2
      local dest_path=$3

      if [[ -d "$pkg/$origin_path" ]]; then
        $lndir/bin/lndir -silent \
          "$pkg/$origin_path"    \
          "$out/$dest_path"
      fi
    }

    linkEmacsPackages() {
      linkPath "$1" "bin" "bin"
      linkPath "$1" "lib" "lib"
      linkPath "$1" "share/emacs/site-lisp" \
        "share/emacs/site-lisp"
      linkPath "$1" "share/emacs/native-lisp" \
        "share/emacs/native-lisp"
    }
  '';

  passthru = {
    pkgs = recurseIntoAttrs (emacsPackagesFor finalAttrs);
  };

  # Emacs needs to find movemail at run time,
  # see info (emacs) Movemail
  propagatedUserEnvPkgs = [
    pkgs.mailutils
  ];

  env = {
    NATIVE_FULL_AOT = "1";
    LIBRARY_PATH =
      lib.concatStringsSep ":" libGccJitLibraryPaths;
  };

  #buildFlags = [];

  #installPhase = '''';

  #postBuild = '''';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Cool editor bro";
    mainProgram = "emacs";
    homepage = "";
    license = licenses.gpl3Plus;
    maintainers = [];
    platforms = platforms.linux;
  };
})
