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
  programs.eza.theme = with config.scheme.withHashtag; {
    colourful = true;

    filekinds = {
      normal = opt base05 { };
      directory = opt base0C { is_bold = true; };
      symlink = opt base0F { };
      pipe = opt base03 { };
      block_device = opt base08 { is_bold = true; };
      char_device = opt base08 { is_bold = true; };
      socket = opt base02 { is_bold = true; };
      special = opt base0E { };
      executable = opt base14 { is_bold = true; };
      mount_point = opt base09 {
        is_bold = true;
        is_underline = true;
      };
    };

    perms = {
      user_read = opt base05 { is_bold = true; };
      user_write = opt base09 { is_bold = true; };
      user_execute_file = opt base0B {
        is_bold = true;
        is_underline = true;
      };
      user_execute_other = opt base0B { is_bold = true; };
      group_read = opt base05 { };
      group_write = opt base09 { };
      group_execute = opt base0B { };
      other_read = opt base05 { };
      other_write = opt base09 { };
      other_execute = opt base0B { };
      special_user_file = opt base0E { };
      special_other = opt base03 { };
      attribute = opt base05 { };
    };

    size = {
      major = opt base0A { is_bold = true; };
      minor = opt base0F { };
      number_byte = opt base05 { is_bold = true; };
      number_kilo = opt base06 { is_bold = true; };
      number_mega = opt base0C { is_bold = true; };
      number_giga = opt base0E { is_bold = true; };
      number_huge = opt base17 { is_bold = true; };
      unit_byte = opt base05 { };
      unit_kilo = opt base0C { };
      unit_mega = opt base0E { };
      unit_giga = opt base17 { };
      unit_huge = opt base09 { };
    };

    users = {
      user_you = opt base05 { is_bold = true; };
      user_root = opt base08 { };
      user_other = opt base0E { };
      group_yours = opt base05 { is_bold = true; };
      group_other = opt base03 { };
      group_root = opt base08 { };
    };

    links = {
      normal = opt base0F { };
      multi_link_file = opt base09 { is_bold = true; background = base00; };
    };

    git = {
      new = opt base0B { };
      modified = opt base09 { };
      deleted = opt base12 { };
      renamed = opt base0C { };
      typechange = opt base0E { };
      ignored = opt base03 { is_dimmed = true; };
      conflicted = opt base12 { };
    };

    git_repo = {
      branch_main = opt base05 { };
      branch_other = opt base0E { };
      git_clean = opt base0B { };
      git_dirty = opt base08 { };
    };

    security_context = {
      colon = opt base03 { is_dimmed = true; };
      user = opt base05 { };
      role = opt base0E { };
      typ = opt base03 { };
      range = opt base0E { };
    };

    file_type = {
      image = opt base0A { };
      video = opt base13 { is_bold = true; };
      music = opt base0E { };
      lossless = opt base17 { is_bold = true; };
      crypto = opt base03 { is_bold = true; };
      document = opt base05 { };
      compressed = opt base0B { };
      temp = opt base08 { };
      compiled = opt base0C { };
      build = opt base04 {
        is_bold = true;
        is_underline = true;
      };
      source = opt base0C { is_bold = true; };
    };

    punctuation = opt base03 { is_dimmed = true; };
    date = opt base09 { };
    inode = opt base05 { };
    blocks = opt base05 { };
    header = opt base05 { is_underline = true; };
    octal = opt base0B { };
    flags = opt base0E { };

    symlink_path = opt base0F { };
    control_char = opt base0C { };
    broken_symlink = opt base12 { };
    broken_path_overlay = opt base03 { is_underline = true; };
  };
}
