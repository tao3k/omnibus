{
  lib,
  fetchurl,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "openinfraquote-bin";
  version = "1.1.0";

  src =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      fetchurl {
        url = "https://github.com/terrateamio/openinfraquote/releases/download/${version}/oiq-linux-amd64-v${version}.tar.gz";
        sha256 = "0vi0w4nia3sx2wh59r5jsxsqb7ddxqyah3n3n4xlraa6wvpda0av";
      }
    else if stdenv.hostPlatform.system == "aarch64-darwin" then
      fetchurl {
        url = "https://github.com/terrateamio/openinfraquote/releases/download/v${version}/oiq-darwin-amd64-v${version}.tar.gz";
        sha256 = "0pkxkb1wj5lkz1nsh0n0k400kz1mzn86i3h8qs24y5xwi7pzg9l6";
      }
    else if stdenv.hostPlatform.system == "aarch64-linux" then
      fetchurl {
        url = "https://github.com/terrateamio/openinfraquote/releases/download/v${version}/oiq-linux-arm64-v${version}.tar.gz";
        sha256 = "13zfp73xnwzckxqxdjlnbl6jhccrinjqz1d3ny1lfzciwldzj8yi";
      }
    else
      throw "Architecture not supported";

  unpackPhase = "tar -xzf $src";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp oiq $out/bin/oiq
    chmod +x $out/bin/oiq

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/terrateamio/openinfraquote";
    description = "OpenInfraQuote is a tool to generate quotes for OpenInfra services";
    license = "MPL-2.0";
    maintainers = [ ];
  };
}
