# CONFIG TO AVOID OVERRINDING FZF BINDKEY
ZVM_INIT_MODE=sourcing
#ZAP_CONFIG===========================================================================================================
  [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
  plug "zsh-users/zsh-autosuggestions"
  plug "zap-zsh/supercharge"
  #plug "zap-zsh/zap-prompt"
  plug "zsh-users/zsh-syntax-highlighting"
  plug "zsh-users/zsh-completions"
  plug "jeffreytse/zsh-vi-mode"
#ZAP_CONFIG===========================================================================================================

#SSH============================
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi
#SSH============================

#Keybindings=======================
  bindkey "^U" backward-kill-line

  # Navigation
  bindkey "^[l" forward-word
  bindkey "^[h" backward-word
  bindkey "^[j" down-line-or-history
  bindkey "^[k" up-line-or-history
  # Sugestions
  bindkey "^ " autosuggest-accept
  bindkey "^H" autosuggest-clear
  # Edit
  bindkey '^H' backward-delete-word
  bindkey '^[[3;5~' delete-word
  bindkey '^[[3~' delete-char
#Keybindings========================

#ShellOptions==================
  setopt HIST_EXPIRE_DUPS_FIRST
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_ALL_DUPS
  setopt HIST_IGNORE_SPACE
  setopt HIST_FIND_NO_DUPS
  setopt HIST_SAVE_NO_DUPS
#ShellOptions==================

##SSH
#eval `~/.scripts/ssh-agent-reuse.sh` &> /dev/null

#Exports========================================================================================================================================================================================================
  export WINHOME=/mnt/c/Users/arce
  export SHIMBASE=/mnt/c/Users/arce/scoop/apps
  export SHIMS=$SHIMBASE/win32yank/current
  export GOPATH=$HOME/go
  export GOBIN=$GOPATH/bin
  export PATH=$SHIMS:$GOPATH:$GOBIN:$HOME/.scripts:$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin:/home/arce/.local/share/JetBrains/Toolbox/scripts:$PATH
#Exports========================================================================================================================================================================================================

#=====================================================================================================HOMBREW
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  if type brew &>/dev/null; then
      FPATH=$(brew --prefix)/share/zsh-completions:/home/linuxbrew/.linuxbrew/share/zsh/site-functions:$FPATH

      autoload -Uz compinit
      compinit
  fi
#=====================================================================================================HOMBREW

#PROMPT=======================
  eval "$(starship init zsh)"
#PROMPT=======================

#=============================fzf
  source <(fzf --zsh)
  source ~/.dotfiles/.config/fzf/settings
#=============================fzf

#nvm============================================================================================================================================================================
  export NVM_DIR="$HOME/.nvm"
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#nvm============================================================================================================================================================================

#.NET=========================================================================
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
#.NET=========================================================================

#ZOXIDE====================
  eval "$(zoxide init zsh)"
#ZOXIDE====================

#SDK_MAN================================================================================
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
#SDK_MAN================================================================================

#pomodoro=============================================
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
#pomodoro=============================================

#pnpm============================================
  export PNPM_HOME="/home/arce/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
#pnpm============================================

#VITASDK===========================================
  export VITASDK=/usr/local/vitasdk
  export PATH=$VITASDK/bin:$PATH # add vitasdk tool to $PATH
#VITASDK===========================================

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/linuxbrew/.linuxbrew/Cellar/tfenv/3.0.0/versions/1.3.5/terraform terraform
