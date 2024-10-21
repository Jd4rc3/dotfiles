export WINHOME=/mnt/c/Users/arce
export SHIMBASE=/mnt/c/Users/arce/scoop/apps
export SHIMS=$SHIMBASE/win32yank/current
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export DOOMBIN=$HOME/.config/emacs/bin
export MASONBIN=$HOME/.local/share/nvim/mason/bin
export PATH=$HOME/.dotnet:$DOOMBIN:$MASONBIN:$SHIMS:$GOPATH:$GOBIN:$HOME/.dotfiles/.scripts:$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin:/home/arce/.local/share/JetBrains/Toolbox/scripts:$PATH
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share:$XDG_DATA_DIRS
export ANDROID_HOME=$HOME/Android/Sdk/
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
export MANPATH="$(brew --prefix)/share/man:$MANPATH"
export DOTNET_HOST_PATH=$HOME/.dotnet/dotnet
