{
  stdenv,
  fetchzip,
  pkgs,
  lib,
  ...
}: let 
  version = "29.4";
in stdenv.mkDerivation rec {
  pname = "emacs";
  inherit version;

  src = fetchzip {
    url = "https://ftp.gnu.org/gnu/emacs/emacs-${version}.tar.gz";
    sha256 =
    "06d2qia2pflsigjkkivjma9cvmc1qjdk4sn5lzlawxjng9icb257";
  };

  nativeBuildInputs = [
    pkgs.libgccjit
    pkgs.libgcc
    pkgs.binutils
    pkgs.gmp
    pkgs.tree-sitter
    pkgs.sqlite
    pkgs.gnutls
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.xorg.libXaw
    pkgs.xorg.libXpm
    pkgs.libpng
    pkgs.libz
    pkgs.libjpeg
    pkgs.libtiff
    pkgs.librsvg
    pkgs.libwebp
    pkgs.texinfo
    pkgs.ncurses
    pkgs.gtk3
  ];

  dontConfigure = false;

  configureFlags = [
    "--host=x86_64-pc-linux-gnu"
    "--target="
    ""

    "--with-pgtk"
    "--with-native-compilation=yes"
    "--with-imagemagick"
    "--with-cairo"
    "--with-modules" # ?
    "--with-json"
    "--with-tree-sitter"
    "--with-small-ja-dic"
    "--with-xwidgets"
  ];

  #postPatch = '''';

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
}
