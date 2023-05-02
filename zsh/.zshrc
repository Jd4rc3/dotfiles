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

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:/home/linuxbrew/.linuxbrew/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh