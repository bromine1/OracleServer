{
  inputs,
  pkgs,
  lib,
  ...
}: let
  # Pin JRE versions used by instances
  jre8 = pkgs.temurin-bin-8;
  jre17 = pkgs.temurin-bin-17;

  # "Borrowed" from AllTheMods Discord
  jvmOpts = lib.concatStringsSep " " [
    "-XX:+UseNUMA"
    "-XX:+UseShenandoahGC"
    "-XX:+UnlockExperimentalVMOptions"
    "-XX:+AlwaysPreTouch"
    "-XX:+UseStringDeduplication"
    "-Dfml.ignorePatchDiscrepancies=true"
    "-Dfml.ignoreInvalidMinecraftCertificates=true"
    "-XX:-OmitStackTraceInFastThrow"
    "-XX:+OptimizeStringConcat"
    "-Dfml.readTimeout=180"
    "-XX:+ParallelRefProcEnabled"
    "-XX:SurvivorRatio=32"
    "-XX:+PerfDisableSharedMem"
    "-XX:MaxTenuringThreshold=1"
    "-Dsun.rmi.dgc.server.gcInterval=2147483646"
  ];

  defaults = {
    # Only people in the Cool Club (tm)
    white-list = true;

    # So I don't have to make everyone op
    spawn-protection = 0;

    # 5 minutes tick timeout, for heavy packs
    max-tick-time = 5 * 60 * 1000;

    # It just ain't modded minecraft without flying around
    allow-flight = true;
  };
in {
  imports = [inputs.ModdedMC.module];
  services.modded-minecraft-servers = {
    eula = true;

    #Servers are stored in /var/name
    instances = {
      # FTBS = {
      #   enable = true;
      #   inherit jvmOpts;
      #   jvmMaxAllocation = "8G";
      #   jvmInitialAllocation = "2G";
      #   jvmPackage = jre17;
      #
      #   rsyncSSHKeys = [
      #     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1YGb985IWR5Uxo0MwIJs7rotfzoxPIU3nEkvbWTvwd ryan@Galaxia"
      #     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
      #   ];
      #
      #   serverConfig = defaults // {
      #     # Port must be unique
      #     server-port = 25566;
      #     motd = "WHADDUP GAMERS";
      #   };
      # };

      #      Minimal = {
      #        enable = true;
      #        inherit jvmOpts;
      #        jvmMaxAllocation = "8G";
      #        jvmInitialAllocation = "2G";
      #        jvmPackage = jre17;
      #
      #        rsyncSSHKeys = [
      #          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1YGb985IWR5Uxo0MwIJs7rotfzoxPIU3nEkvbWTvwd ryan@Galaxia"
      #          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
      #        ];
      #
      #        serverConfig = defaults // {
      #          # Port must be unique
      #          server-port = 25566;
      #          motd = "WHADDUP GAMERS";
      #        };
      #      };
      AOF6 = {
        enable = true;
        inherit jvmOpts;
        jvmMaxAllocation = "8G";
        jvmInitialAllocation = "2G";
        jvmPackage = jre17;

        rsyncSSHKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID1YGb985IWR5Uxo0MwIJs7rotfzoxPIU3nEkvbWTvwd ryan@Galaxia"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
        ];

        serverConfig =
          defaults
          // {
            # Port must be unique
            server-port = 25566;
            motd = "WHADDUP GAMERS";
          };
      };
    };
  };
}
