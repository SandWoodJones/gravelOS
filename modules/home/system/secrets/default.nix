{
  config,
  inputs,
  ...
}:
{
  sops = {
    defaultSopsFile = "${inputs.self}/secrets.yaml";

    age = {
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    };
  };
}
