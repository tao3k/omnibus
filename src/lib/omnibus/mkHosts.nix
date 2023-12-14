{super}:
{
  hostsDir,
  pops,
  addLoadExtender ? {load = {};},
}:
super.addLoadToPopsFilterBySrc hostsDir pops addLoadExtender
