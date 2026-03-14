{
  config,
  pkgs,
  ...
}: {
  git = {
    enable = true;
    ignores = [
      "*~"
      "*.swp"
      "/node-modules"
    ];
    settings = {
      user = {
        email = "denis@manherz.de";
        name = "Denis Manherz";
      };

      init.defaultBranch = "main";
    };
  };
  delta.enable = true;
}
