{ inputs, ... }:
{
  imports = [ inputs.ModdedMC.module ];
  services.modded-minecraft-servers = {
    eula = true;

    #Servers are stored in /var/name
    instances = {
      e2es = {
        enable = true;

        rsyncSSHKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGldrYw25J0K2LyZNhTakj66yYrUfrmK34WiyHa/91r ryan@Galaxia"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
        ];

        serverConfig = {
          # Port must be unique
          server-port = 25566;
          motd = "Welcome to Enigmatica 2: Expert Skyblock";
        };
      };
    };
  };

}
