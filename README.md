# Instructions

## Pre-requisites:

- Highlight: `brew install highlight`.
- Chruby: `brew install chruby ruby-install`.

## Install

1. Install oh-my-zsh.
2. Install the following plugins not included in oh-my-zsh:

   1. zsh-autosuggestions
   2. zsh-abbr

3. Ensure you have this in your `.zshrc` file:

   ```zsh
    export ZSH="$HOME/.oh-my-zsh"

    ZSH_THEME="mine"

    plugins=(zsh-autosuggestions z zsh-abbr extract)

    source $ZSH/oh-my-zsh.sh
   ```

4. Enjoy!
