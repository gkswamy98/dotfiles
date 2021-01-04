# I use iTerm2 with the following customizations
# Nord Theme: https://github.com/arcticicestudio/nord-iterm2
# FiraCode font: https://github.com/tonsky/FiraCode

# Path to your oh-my-zsh installation.
export ZSH="/Users/gswamy/.oh-my-zsh"
ZSH_DISABLE_COMPFIX="false"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

#npm install --global pure-prompt

# oh-my-zsh overrides the prompt, so Pure must be activated after `source $ZSH/oh-my-zsh.sh`
# .zshrc
autoload -U promptinit; promptinit
prompt pure

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
	 zsh-syntax-highlighting
         zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
