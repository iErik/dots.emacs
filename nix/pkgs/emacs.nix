{
  stdenv,
  fetchzip,
  pkgs,
  ...
}: stdenv.mkDerivation rec {
  pname: "emacs";
  version: "29.4";

  src = fetchzip {
    url = "https://ftp.gnu.org/gnu/emacs/emacs-29.4.tar.gz";
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

  build-inputs = [
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

  post-patch = "";

  buildFlags = [];

  installPhase = "";

  postBuild = "";

  meta = with lib; {
    description = "";
    mainProgram = "";
    homepage = "";
    license = licenses.bsd3;
    maintainers = [];
    platforms = platforms.x86_64;
  };
}
