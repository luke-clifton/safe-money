{ mkDerivation, ghc, aeson, base, binary, bytestring, cereal
, constraints, deepseq, hashable, stdenv, tasty, tasty-hunit
, tasty-quickcheck, store ? null
}:
let isGhcjs = ghc.isGhcjs or false;
in mkDerivation {
  pname = "safe-money";
  version = "0.2";
  src = ./.;
  libraryHaskellDepends = [
    aeson base binary cereal constraints deepseq hashable
  ] ++ (stdenv.lib.optionals (!isGhcjs) [ store ]);
  testHaskellDepends = [
    aeson base binary bytestring cereal constraints deepseq hashable
    tasty tasty-hunit tasty-quickcheck
  ] ++ (stdenv.lib.optionals (!isGhcjs) [ store ]);
  configureFlags = stdenv.lib.optionals isGhcjs [ "-f-store" ];
  homepage = "https://github.com/k0001/safe-money";
  description = "Type-safe and lossless encoding and manipulation of money, world currencies and precious metals";
  license = stdenv.lib.licenses.bsd3;
}
