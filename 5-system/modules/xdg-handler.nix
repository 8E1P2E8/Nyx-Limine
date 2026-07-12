{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    grype
    syft
    cosign
  ];
}
