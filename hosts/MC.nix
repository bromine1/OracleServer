{ inputs, pkgs, ... }:
let
  # Pin JRE versions used by instances
  jre8 = pkgs.temurin-bin-8;
  jre17 = pkgs.temurin-bin-17;

  # "Borrowed" from AllTheMods Discord
  jvmOpts = concatStringsSep " " [
    "-XX:+UseG1GC"
    "-XX:+ParallelRefProcEnabled"
    "-XX:MaxGCPauseMillis=200"
    "-XX:+UnlockExperimentalVMOptions"
    "-XX:+DisableExplicitGC"
    "-XX:+AlwaysPreTouch"
    "-XX:G1NewSizePercent=40"
    "-XX:G1MaxNewSizePercent=50"
    "-XX:G1HeapRegionSize=16M"
    "-XX:G1ReservePercent=15"
    "-XX:G1HeapWastePercent=5"
    "-XX:G1MixedGCCountTarget=4"
    "-XX:InitiatingHeapOccupancyPercent=20"
    "-XX:G1MixedGCLiveThresholdPercent=90"
    "-XX:G1RSetUpdatingPauseTimePercent=5"
    "-XX:SurvivorRatio=32"
    "-XX:+PerfDisableSharedMem"
    "-XX:MaxTenuringThreshold=1"
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

in
{
  imports = [ inputs.ModdedMC.module ];
  services.modded-minecraft-servers = {
    eula = true;

    #Servers are stored in /var/name
    instances = {
      FTBS = {
        enable = true;
        inherit jvmOpts;
        jvmMaxAllocation = "8G";
        jvmInitialAllocation = "2G";
        jvmPackage = jre17;

        rsyncSSHKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGldrYw25J0K2LyZNhTakj66yYrUfrmK34WiyHa/91r ryan@Galaxia"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
        ];

        serverConfig = defaults // {
          # Port must be unique
          server-port = 25566;
          motd = "WHADDUP GAMERS";
        };
      };
    };
  };


}
