{ omnibus }:
{
  imports = [ omnibus.srvos.common.openssh ];
  services.openssh = {
    enable = true;
  };
}
