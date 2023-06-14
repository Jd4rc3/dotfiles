# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"


#Keybindings
bindkey "^U" backward-kill-line

bindkey "^[l" forward-word
bindkey "^[h" backward-word
bindkey "^[j" down-line-or-history
bindkey "^[k" up-line-or-history

bindkey "^ " autosuggest-accept
bindkey "^H" autosuggest-clear

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word


setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

##SSH
eval `~/.scripts/ssh-agent-reuse.sh` &> /dev/null

# Exports
export PATH="$HOME/.scripts:$PATH"

# Completions from brew
# for file in /home/linuxbrew/.linuxbrew/share/zsh/site-functions/*; do
#     source "$file"
# done

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:/home/linuxbrew/.linuxbrew/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.dotfiles/fzf/settings

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:/home/arce/.local/share/JetBrains/Toolbox/scripts:$PATH

#########################
#Add .NET Core SDK tools#
#########################
export DOTNET_ROOT=$HOME/.dotnet/
export PATH="$PATH:/home/arce/.dotnet/tools:$HOME/.dotnet"

# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet

alias nuget="mono /usr/local/bin/nuget.exe"
