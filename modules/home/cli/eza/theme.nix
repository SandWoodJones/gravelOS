# TODO: configure eza theme (https://www.color-hex.com/color-palette/59231, https://github.com/slipnox/blackai-theme/blob/master/themes/blackai-theme.json, https://gist.github.com/brayevalerien/cb94ac685ebc186f359deae113b6710c)
{
  lib,
  config,
  ...
}:
let
  cfg = config.gravelOS.cli.eza;

  opt = color: set: { foreground = color; } // set;
in
lib.mkIf cfg.enable {
  programs.eza.theme = {
    colourful = true;

    filekinds = {
      normal = opt "Default" { };
      directory = opt "Blue" { is_bold = true; };
      symlink = opt "Cyan" { };
      pipe = opt "Yellow" { };
      block_device = opt "Yellow" { is_bold = true; };
      char_device = opt "Yellow" { is_bold = true; };
      socket = opt "Red" { is_bold = true; };
      special = opt "Yellow" { };
      executable = opt "Green" { is_bold = true; };
      mount_point = opt "Blue" {
        is_bold = true;
        is_underline = true;
      };
    };

    perms = {
      user_read = opt "Yellow" { is_bold = true; };
      user_write = opt "Red" { is_bold = true; };
      user_execute_file = opt "Green" {
        is_bold = true;
        is_underline = true;
      };
      user_execute_other = opt "Green" { is_bold = true; };
      group_read = opt "Yellow" { };
      group_write = opt "Red" { };
      group_execute = opt "Green" { };
      other_read = opt "Yellow" { };
      other_write = opt "Red" { };
      other_execute = opt "Green" { };
      special_user_file = opt "Purple" { };
      special_other = opt "Purple" { };
      attribute = opt "Default" { };
    };

    size = {
      major = opt "Green" { is_bold = true; };
      minor = opt "Green" { };
      number_byte = opt "Green" { is_bold = true; };
      number_kilo = opt "Green" { is_bold = true; };
      number_mega = opt "Green" { is_bold = true; };
      number_giga = opt "Green" { is_bold = true; };
      number_huge = opt "Green" { is_bold = true; };
      unit_byte = opt "Green" { };
      unit_kilo = opt "Green" { };
      unit_mega = opt "Green" { };
      unit_giga = opt "Green" { };
      unit_huge = opt "Green" { };
    };

    users = {
      user_you = opt "Yellow" { is_bold = true; };
      user_root = opt "Default" { };
      user_other = opt "Default" { };
      group_yours = opt "Yellow" { is_bold = true; };
      group_other = opt "Default" { };
      group_root = opt "Default" { };
    };

    links = {
      normal = opt "Red" { is_bold = true; };
      multi_link_file = opt "Red" { background = "Yellow"; };
    };

    git = {
      new = opt "Green" { };
      modified = opt "Blue" { };
      deleted = opt "Red" { };
      renamed = opt "Yellow" { };
      typechange = opt "Purple" { };
      ignored = opt "Default" { is_dimmed = true; };
      conflicted = opt "Red" { };
    };

    git_repo = {
      branch_main = opt "Green" { };
      branch_other = opt "Yellow" { };
      git_clean = opt "Green" { };
      git_dirty = opt "Yellow" { };
    };

    security_context = {
      colon = opt "Default" { is_dimmed = true; };
      user = opt "Blue" { };
      role = opt "Green" { };
      typ = opt "Yellow" { };
      range = opt "Cyan" { };
    };

    file_type = {
      image = opt "Purple" { };
      video = opt "Purple" { is_bold = true; };
      music = opt "Cyan" { };
      lossless = opt "Cyan" { is_bold = true; };
      crypto = opt "Green" { is_bold = true; };
      document = opt "Green" { };
      compressed = opt "Red" { };
      temp = opt "White" { };
      compiled = opt "Yellow" { };
      build = opt "Yellow" { is_bold = true; is_underline = true; };
      source = opt "Yellow" { is_bold = true; };
    };

    punctuation = opt "DarkGray" { is_bold = true; };
    date = opt "Blue" { };
    inode = opt "Purple" { };
    blocks = opt "Cyan" { };
    header = opt "Default" { is_underline = true; };
    octal = opt "Purple" { };
    flags = opt "Default" { };

    symlink_path = opt "Cyan" { };
    control_char = opt "Red" { };
    broken_symlink = opt "Red" { };
    broken_path_overlay = opt "Default" { is_underline = true; };
  };
}
