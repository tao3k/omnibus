{
  lib,
  fetchurl,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "openinfraquote-bin";
  version = "1.10.0";

  src =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      fetchurl {
        url = "https://github.com/terrateamio/openinfraquote/releases/download/${version}/oiq-linux-amd64-v${version}.tar.gz";
        sha256 = "03974x53f904lz4axnwbf25vjsj94sn6s46cb0z1ww5zfs59xc6v";
      }
    else if stdenv.hostPlatform.system == "aarch64-darwin" then
      fetchurl {
        url = "https://github.com/terrateamio/openinfraquote/releases/download/v${version}/oiq-darwin-amd64-v${version}.tar.gz";
        sha256 = "0pqb79kp9zx8dc0f6haxcnpwhw9lc146qrqm1wd0k6075i979w7i";
      }
    else if stdenv.hostPlatform.system == "aarch64-linux" then
      fetchurl {
        url = "https://github.com/terrateamio/openinfraquote/releases/download/v${version}/oiq-linux-arm64-v${version}.tar.gz";
        sha256 = "0mfnwf4xwbwfrv5mark2sk16xhq0qq76w9872q6fm68j8hym2bvi";
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
    mainProgram = "oiq";
    homepage = "https://github.com/terrateamio/openinfraquote";
    description = "OpenInfraQuote is a tool to generate quotes for OpenInfra services";
    license = "MPL-2.0";
    maintainers = [ ];
  };
}
