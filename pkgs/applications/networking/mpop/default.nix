{ lib, stdenv, fetchurl, pkg-config, gnutls, gsasl, libidn, Security }:

with lib;

stdenv.mkDerivation rec {
  pname = "mpop";
  version = "1.4.12";

  src = fetchurl {
    url = "https://marlam.de/${pname}/releases/${pname}-${version}.tar.xz";
    sha256 = "sha256-X2NVtS2cNgYZYjpAxmwaVXHjk7Q/5YN1wN41QprDSAo=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ gnutls gsasl libidn ]
    ++ optional stdenv.isDarwin Security;

  configureFlags = optional stdenv.isDarwin [ "--with-macosx-keyring" ];

  meta = {
      description = "POP3 mail retrieval agent";
      homepage = "https://marlam.de/mpop";
      license = licenses.gpl3Plus;
      platforms = platforms.unix;
    };
}
