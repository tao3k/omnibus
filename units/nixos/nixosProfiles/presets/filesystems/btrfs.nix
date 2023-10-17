{
  # protect data integrity
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
}
