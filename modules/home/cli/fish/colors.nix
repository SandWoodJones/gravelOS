{
  config,
}:
with config.scheme; # fish
''
  set -g fish_color_normal "${base05}" # default color
  set -g fish_color_command "${base0D}" "--bold" # commands like `echo`
  set -g fish_color_keyword "${base0E}" "--bold" # keywords like `if`
  set -g fish_color_quote "${base0B}" # quoted text like "abc"
  set -g fish_color_redirection "${base0E}" # IO redirections like `>/dev/null`
  set -g fish_color_end "${base0C}" "--dim" # process separators like `;` and `&`
  set -g fish_color_error "${base12}" # syntax errors
  set -g fish_color_param "${base13}" # ordinary command parameters
  set -g fish_color_valid_path "${base13}" "--underline" # parameters that are filenames (if the file exists)
  set -g fish_color_option "${base09}" # options starting with `-`, up to the first `--` parameter
  set -g fish_color_comment "${base03}" # comments like `# important`
  set -g fish_color_selection "${base01}" "--background=${base02}" # selected text in vi visual mode
  set -g fish_color_operator "${base0C}" # parameter expansion characters like `*` and `~`
  set -g fish_color_escape "${base15}" "--dim" # character escapes like `\n` and `\x70`
  set -g fish_color_autosuggestion "${base03}" # autosuggestions
  set -g fish_color_search_match "--background=${base02}" # history search matches and selected pager items
  set -g fish_color_history_current "--underline" "--bold" # the current position in the history for commands like `dirh` and `cdh`
  # PAGER COLORS
  set -g fish_pager_color_progress "${base04}" "--background=${base00}" "--dim" # the progress bar at the bottom left corner
  set -g fish_pager_color_prefix "--underline" "--bold" # the prefix string
  set -g fish_pager_color_completion "--bold" # the completion itself
  set -g fish_pager_color_description "${base04}" # the completion description
  set -g fish_pager_color_selected_background "--background=${base02}" # background of the selected completion
''
