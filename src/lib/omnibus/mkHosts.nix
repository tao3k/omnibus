{super}:
{
  hostsDir,
  pops,
  addLoadExtender ? {},
}:
super.addLoadToPopsFilterBySrc hostsDir pops addLoadExtender
