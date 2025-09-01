# TODO: use gnome keyring for declarative credentials
# TODO: checkout https://beb.ninja/post/email/ and https://sbr.pm/configurations/mails.html

{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.desktop.thunderbird;
in
{
  programs.thunderbird.enable = true;
  programs.thunderbird.profiles.swjones.isDefault = true;
  # accounts.email.accounts.work = {
  #   primary = true;
  #   address = "sandwoodjones@gmail.com";
  #   userName = "sandwoodjones@gmail.com";
  #   realName = "...";
  #   passwordCommand = "echo '...'";
  #   imap = {
  #     host = "imap.gmail.com";
  #     port = 993;
  #   };
  #   smtp.host = "smtp.gmail.com";
  #   thunderbird.enable = true;
  # };
}
