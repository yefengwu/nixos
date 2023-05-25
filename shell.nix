{ nixpkgs ? import <nixpkgs> { } }:
with nixpkgs; mkShellNoCC {
  nativeBuildInputs = [
    fswatch
    hugo
    nodePackages.autoprefixer
    nodePackages.postcss-cli
  ];
}
