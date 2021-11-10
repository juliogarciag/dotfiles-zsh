# Instructions

## Pre-requisites:

- Highlight: `brew install highlight`.
- ASDF: `brew install asdf`.

## Install

1. Install [oh-my-zsh](https://ohmyz.sh/#install).
2. Clone this repository into your custom folder:

   ```bash
   $ cd ~/.oh-my-zsh
   $
   ```

3. Install the following plugins not included in oh-my-zsh:

   1. [zsh-abbr](https://github.com/olets/zsh-abbr)
   2. [zsh-asdf](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/asdf)

4. Ensure you have this in your `.zshrc` file:

   ```zsh
   export ZSH="$HOME/.oh-my-zsh"

   ZSH_THEME="mine"

   plugins=(z zsh-abbr extract)

   source $ZSH/oh-my-zsh.sh
   source /usr/local/opt/asdf/libexec/asdf.sh
   ```

5. Enjoy!
