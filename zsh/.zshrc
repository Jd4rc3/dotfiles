# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
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
#eval `~/.scripts/ssh-agent-reuse.sh` &> /dev/null

# Exports
export PATH=$HOME/.scripts:$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin:/home/arce/.local/share/JetBrains/Toolbox/scripts:$PATH

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
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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
#########################
eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

############# pywal
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

############# pomodoro
declare -A pomo_options
pomo_options["work"]="25"
pomo_options["break"]="5"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  notify-send "Time's up"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"


# Load Angular CLI autocompletion.
source <(ng completion script)
