{ mkDerivation, base, hakyll, hakyll-sass, stdenv }:
mkDerivation {
  pname = "nix-hakyll-test";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base hakyll hakyll-sass ];
  license = stdenv.lib.licenses.bsd3;
}
