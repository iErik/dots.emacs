{
  stdenv,
  fetchzip,
  pkgs,
  ...
}: let 
  version = "29.4";
in stdenv.mkDerivation rec {
  pname: "emacs";
  inherit version;

  src = fetchzip {
    url = "https://ftp.gnu.org/gnu/emacs/emacs-${version}.tar.gz";
    sha256 =
    "06d2qia2pflsigjkkivjma9cvmc1qjdk4sn5lzlawxjng9icb257";
  };

  nativeBuildInputs = [
    pkgs.libgccjit
    pkgs.binutils
    pkgs.gmp
    pkgs.tree-sitter
    pkgs.sqlite
    pkgs.gnutls
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
  ];

  dontConfigure = false;

  configureFlags = [
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

  meta = with lib; {
    description = "Cool editor bro";
    mainProgram = "emacs";
    homepage = "";
    license = licenses.gpl3Plus;
    maintainers = [];
    platforms = platforms.linux;
  };
}
