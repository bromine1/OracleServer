{ config
, lib
, pkgs
, user
, inputs
, nix-colors
, nix-doom-emacs
, ...
}:

let
in
{
  nixpkgs.config.allowUnfree = true;
  #cachic  


  home.stateVersion = "22.11";
  programs.home-manager.enable =
    true; # enable home manager and allow it to manage itself

  systemd.user.startServices =
    "sd-switch"; # reload systemd units on config reload

  home = {
    username = "opc";
    homeDirectory = "/home/opc";

    packages = with pkgs; [
      gh
      git
      zellij
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "fish";
  };
  # User Configuration
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  imports = [


    ./modules/CLI/Tools.nix
    ./modules/CLI/btop
    ./modules/shells/Fish
    #./modules/shells/nushell
    ./modules/shells/Starship


  ];

}

