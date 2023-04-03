{ inputs, ... }:
{
  imports = [ inputs.ModdedMC.module ];

  services.modded-minercraft-servers = {
    eula = true;

    #Servers are stored in /var/name
    temp = {
      enable = true;
    };
  };

}
