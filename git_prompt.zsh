function git_prompt() {
  local GIT_STATUS_ORDER=(added modified renamed copied deleted untracked unmerged)

  declare -A STATUS_COLORS
  local STATUS_COLORS=(
    added green
    modified cyan
    renamed magenta
    copied magenta
    deleted yellow
    untracked yellow
    unmerged red
  )

  declare -A STATUS_TEXTS
  local STATUS_TEXTS=(
    added a
    modified M
    renamed r
    copied c
    deleted d
    untracked u
    unmerged "!"
  )

  local BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`

  if  [[ $BRANCH = '' ]]; then
    return
  fi

  echo -n "%F{yellow}|%f"

  local INDEX=`git status --porcelain 2> /dev/null | cut -c 1-2 | sort -u`

  if [[ $INDEX = '' ]] then
    echo " %F{green}$BRANCH%f"
    echo -n " "
    return
  fi

  local GS
  local STAGED

  while IFS= read -r i; do
    local MAYBE_STAGED=`echo $i | grep '^[AMRCD]' 2> /dev/null`

    if ! [[ $MAYBE_STAGED = '' ]]; then
      STAGED=1
    fi

    case "$i" in
      'A ')
        GS="$GS added"
        ;;
      'M ')
        GS="$GS modified"
        ;;
      ' M')
        GS="$GS modified"
        ;;
      'R ')
        GS="$GS renamed"
        ;;
      'C ')
        GS="$GS copied"
        ;;
      'D ')
        GS="$GS deleted"
        ;;
      ' D')
        GS="$GS deleted"
        ;;
      '\?\?')
        GS="$GS untracked"
        ;;
      'U*')
        GS="$GS unmerged"
        ;;
      '*U')
        GS="$GS unmerged"
        ;;
      'DD')
        GS="$GS unmerged"
        ;;
      'AA')
        GS="$GS unmerged"
        ;;
    esac
  done <<< "$INDEX"

  echo -n "%F{magenta} $BRANCH%f"

  for i in $GIT_STATUS_ORDER; do
    if test "${GS#*$i}" != "$GS"; then
      local COLOR="$STATUS_COLORS[$i]"
      echo -n "%F{$COLOR} [$STATUS_TEXTS[$i]]%f"
    fi
  done

  echo -n " "
}
