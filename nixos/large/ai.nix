{lib, ...}:
{
  services.invokeai.enable = false;
  services.invokeai.user = "denis";
  services.invokeai.group = "users";
  services.invokeai.settings = {
    root = "/home/denis/.invokeai";
  };
  services.a1111.enable = true;
  services.a1111.user = "denis";
  services.a1111.group = "users";
  services.a1111.settings.port = 9999;
  services.a1111.settings.ckpt-dir = "/home/denis/.invokeai/autoimport/main";
  services.a1111.extraArgs = ["--no-download-sd-model" "--medvram" "--no-half-vae" ];
  systemd.services.a1111.serviceConfig.Restart = lib.mkForce "always";
}
