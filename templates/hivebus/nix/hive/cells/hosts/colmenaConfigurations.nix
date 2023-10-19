{ inputs, cell }:
{
  example = {
    deployment = {
      allowLocalDeployment = true;
      targetHost = "127.0.0.1";
    };
    inherit (cell.nixosConfigurations.example) bee imports;
  };
}
