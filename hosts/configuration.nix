{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix


  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "instance-20230204-1757";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGldrYw25J0K2LyZNhTakj66yYrUfrmK34WiyHa/91r ryan@Galaxia"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
  ];

  system.stateVersion = "23.05";


  users.users.opc = {
    isNormalUser = true;
    description = "server user";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "plugdev" ];
    # import modules
    packages = with pkgs; [ ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGldrYw25J0K2LyZNhTakj66yYrUfrmK34WiyHa/91r ryan@Galaxia"
    ];
    initialPassword = "password"; # TODO fix later with sops-nix
  };
  programs.fish.enable = true;
}
