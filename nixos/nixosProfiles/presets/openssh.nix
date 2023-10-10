{ omnibus }:
{
  imports = [ omnibus.srvos.layouts.default.common.openssh ];
  services.openssh = {
    enable = true;
  };
}
