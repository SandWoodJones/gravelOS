{
  lib,
  ...
}:
let
  mkGitAbbr = expansion: {
    inherit expansion;
    command = "git";
  };

  mkGitSubAbbr =
    {
      key,
      name,
      subcommand,
      expansion,
    }:
    let
      funcName = "__fish_abbr_git_${key}";
    in
    {
      shellAbbrs."git-${key}" = {
        inherit name;
        command = "git";
        function = funcName;
      };

      functions."${funcName}" =
        #fish
        ''
          if commandline -p | string match -qr '^git ${subcommand}'
            echo '${expansion}'
          end
        '';
    };
in
{
  programs.fish = lib.mkMerge [
    {
      shellAbbrs = {
        gs = "git status";
        gui = "gitui";

        df = mkGitAbbr "diff";

        rb = mkGitAbbr "rebase";

        pop = {
          command = "git";
          function = "__fish_abbr_git_pop";
        };
      };

      functions = {
        "__fish_abbr_git_pop" =
          # fish
          ''
            commandline -p | string match -qr '^git stash pop'; and return 1
            echo 'stash pop' 
          '';
      };
    }

    (mkGitSubAbbr {
      key = "diff-staged";
      name = "s";
      subcommand = "diff";
      expansion = "--staged";
    })
    (mkGitSubAbbr {
      key = "rebase-interactive";
      name = "i";
      subcommand = "rebase";
      expansion = "--interactive";
    })
    (mkGitSubAbbr {
      key = "rebase-continue";
      name = "c";
      subcommand = "rebase";
      expansion = "--continue";
    })
    (mkGitSubAbbr {
      key = "stash-rebase";
      name = "rebase";
      subcommand = "stash";
      expansion = ''push --keep-index -m "unstaged" && git stash push -m "staged"'';
    })
  ];
}
