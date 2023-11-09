{
  lib,
  yants,
  self,
}:
with yants; {
  a = struct "test" { name = string; };
  b = either self.a (struct { age = int; });
}
