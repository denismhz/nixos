{ config, pkgs, ... }:
{
  tealdeer = {
    enable = true;
    settings = {
      display = {
        compact = true;
        use_pager = false;
      };
      updates = {
        auto_update = true;
      };
    };
  };
}
