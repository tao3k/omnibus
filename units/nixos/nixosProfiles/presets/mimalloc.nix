{
  environment.memoryAllocator.provider = "mimalloc";
  nixpkgs.overlays = [
    (_: prev: {
      dhcpcd = prev.dhcpcd.override { enablePrivSep = false; };
    })
  ];
}
