if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=( 
    git
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Dotnet
export PATH="$HOME/.dotnet/tools:$PATH"

# Scripts
export PATH="$HOME/.scripts:$PATH"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Lazy-load NVM
#export NVM_DIR="$HOME/.nvm"

#load_nvm() {
  #unalias nvm node npm npx 2>/dev/null
  #[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  #[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  #"$@"
#}

#alias nvm='load_nvm nvm'
#alias node='load_nvm node'
#alias npm='load_nvm npm'
#alias npx='load_nvm npx'

    
