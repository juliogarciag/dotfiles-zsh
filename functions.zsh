function reload() {
  source ~/.zshrc
}

function e() {
  eval $VISUAL_EDITOR $argv
}

function ez() {
  z $argv
  e .
  cd -
}

function cdp() {
  cd "$PROJECTS_DIR/$argv"
}

function rm() {
  command rm -i $argv
}

function rm!() {
  command rm $argv
}

function show-code() {
  local filename=$argv[1]
  local syntax=`file-extension $filename`
  local format="xterm256"

  cat $filename | highlight --syntax=$syntax --out-format=$format | less -R
}

function file-extension() {
  local filename=$argv[1]
  echo $filename:t:e
}

function finder() {
  open -a 'Finder' $argv[1]
}

function configme() {
  git config --global user.email "julio.garcia@hey.com"
  git config --global user.name "juliogarciag"
  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
}

function gac() {
  git add -A
  git commit -m $argv[1]
}

function gacp() {
  local branch=`git branch | grep '*' | awk '{print $2}'`
  gac $argv[1]
  git push -u origin $branch
}

function short_pwd {
  echo $PWD | sed "s:${HOME}:~:" | sed "s:/\(.\)[^/]*:/\1:g" | sed "s:/[^/]*$:/$(basename $PWD):"
}
