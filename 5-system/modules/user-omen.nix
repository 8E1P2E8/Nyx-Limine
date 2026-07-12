# User configuration for 'omen'
_:
{
  users.users.omen = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDT+/kH7IJOVqYUbCREeAF/xi7Sd814onkydZOA+6tAx latitude5400@latitude5400"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHs7k8YOOCMbycDX0AR59F0mfqpCRzd9xRYvo73IOfX EPE@latitude5400-router"
    ];
  };
  users.groups.omen = { };
}
