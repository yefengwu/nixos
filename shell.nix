{ nixpkgs ? import <nixpkgs> { } }:
with nixpkgs; mkShellNoCC {
  nativeBuildInputs = [
    wget
    gawk
    gcc9
    gnumake42
    gperf
    unzip
    zip
    texinfo
    bison
    flex
    git
    quilt
    autoconf
    automake
    libtool
  ];
}
