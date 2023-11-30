# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# copyright: https://github.com/cpcloud/nix-config
{
  config,
  lib,
  pkgs,
  ...
}:
let
  enableNvidiaDocker = config.virtualisation.docker.enableNvidia;
  enableNvidiaPodman = config.virtualisation.podman.enableNvidia;
  # test scripts for the nvidia docker runtime, for docker and podman if they
  # are enabled
  tensorflowImage = "tensorflow/tensorflow:${pkgs.python3Packages.tensorflow.version}-gpu";
  cudaImage = "nvidia/cuda:${pkgs.cudatoolkit_11.version}-base-ubi7";

  pythonScript = ''
    import tensorflow as tf

    devices = tf.config.list_physical_devices(\"GPU\")
    assert devices, \"no GPU devices found\"

    print(\"\n\".join(map(repr, devices)))
  '';

  testNVidiaContainerSimple =
    runtime:
    pkgs.writeShellApplication {
      name = "test_nvidia_${runtime}_simple";
      runtimeInputs = [pkgs.${runtime}];
      text = ''
        set -x

        "${runtime}" run --runtime nvidia --rm "${cudaImage}" nvidia-smi --list-gpus
      '';
    };

  testNVidiaContainerTensorFlow =
    runtime:
    pkgs.writeShellApplication {
      name = "test_nvidia_${runtime}_tensorflow";
      runtimeInputs = [pkgs.${runtime}];
      text = ''
        set -x

        ${runtime} \
          run \
          -e TF_CPP_MIN_LOG_LEVEL=1 \
          -e LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu \
          --runtime nvidia \
          --rm \
          ${tensorflowImage} \
          python -c "${pythonScript}"
      '';
    };

  genScripts = runtime: [
    (testNVidiaContainerSimple runtime)
    (testNVidiaContainerTensorFlow runtime)
  ];
in
{
  environment.systemPackages =
    lib.optionals enableNvidiaDocker (genScripts "docker")
    ++ lib.optionals enableNvidiaPodman (genScripts "podman");
}
