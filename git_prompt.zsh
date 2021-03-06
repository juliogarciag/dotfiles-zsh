function git_prompt() {
  local GIT_STATUS_ORDER=(added modified renamed copied deleted untracked unmerged)

  declare -A STATUS_COLORS
  local STATUS_COLORS=(
    added green
    modified blue
    renamed magenta
    copied magenta
    deleted red
    untracked yellow
    unmerged red
  )

  local BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`

  if  [[ $BRANCH = '' ]]; then
    return
  fi

  printf '|'

  local INDEX=`git status --porcelain 2> /dev/null | cut -c 1-2 | sort -u`

  if [[ $INDEX = '' ]] then
    echo " %{$fg[green]%}$BRANCH %{$reset_color%}"
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

  if [[ $STAGED = 1 ]]; then
    echo -n "%{$fg[yellow]%} $BRANCH"
  else
    echo -n "%{$fg[red]%} $BRANCH"
  fi

  for i in $GIT_STATUS_ORDER; do
    if test "${GS#*$i}" != "$GS"; then
      local COLOR="$STATUS_COLORS[$i]"
      echo -n "$fg[$COLOR] [$i]"
    fi
  done

  echo -n " "
}
