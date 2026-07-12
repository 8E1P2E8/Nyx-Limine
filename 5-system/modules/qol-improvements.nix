{ pkgs, inputs, ... }: {
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
  ];
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;
}
