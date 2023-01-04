export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:/home/arce/.local/share/JetBrains/Toolbox/scripts:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
	zsh-autosuggestions
	git
	history
	sudo
	web-search
	fast-syntax-highlighting
	copyfile
	copypath
	copybuffer
	dirhistory
    extract
    git-flow-completion
	);

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

###################
#     Aliases     #
###################
alias zshrc="nvim ~/.zshrc"
alias i3rc="nvim ~/.dotfiles/i3/config"
alias bspwmrc="nvim ~/.dotfiles/bspwm/bspwmrc"
alias sxhkdrc="nvim ~/.dotfiles/sxhkd/sxhkdrc"
alias rangerc="nvim $HOME/.config/ranger"
alias kittyrc="nvim ~/.dotfiles/kitty/kitty.conf"
alias polybarc="code ~/.dotfiles/polybar/"
alias cp="cp -v"
alias mv="mv -vi"
alias rm="rm -vi"
alias current-milis="data +%s%3N"
alias lv="lvim"
alias vim="nvim"
alias v="nvim"
alias dot="cd ~/.dotfiles"
alias kat="bat"
alias ws="cd ~/workspace"
alias dw="cd ~/Downloads/"
alias repos="cd ~/Downloads/.repos/"
alias icat="kitty +kitten icat"                                               
#alias d="kitty +kitten diff"
alias za="zathura"
alias p="python3"
alias r="ranger"
alias j="java -jar"
alias y="yay"
alias l="exa --icons -la"
alias li="exa --icons"
alias ls='lsd -a --group-directories-first'
alias ll='lsd -la --group-directories-first'
alias todo="glow ~/Development/workspace/TODO.md"
alias ntodo="nvim ~/Development/workspace/TODO.md"
alias lg="lazygit"
alias ld="lazydocker"
alias hyprc="lvim ~/.config/hypr/hyprland.conf"
alias kbinds="lvim ~/.config/hypr/keybinds.conf"
alias wal="lvim ~/.config/hypr/hyprpaper.conf"
alias lsgh="gh repo-fzf"
alias dt="dotnet"

#ssh
alias main="ssh-add -D && ssh-add ~/.ssh/edu"
alias second="ssh-add -D && ssh-add ~/.ssh/id_ed25519"
alias sofka="ssh-add -D && ssh-add ~/.ssh/sofka"

#gitflow
alias gffs="git flow feature start"
alias gfff="git flow feature finish"

#utilities
alias cpu-status="auto-cpufreq --stats"

alias check-battery="cat /sys/class/power_supply/BAT0/status"

alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias maintenance="yay -Sc && sudo pacman -Scc"

alias purge="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"

alias aur-update="yay -Syu"

alias pacman-update="sudo pacman -Syu"

alias doff="sudo systemctl stop docker.socket"

alias vm-on="sudo systemctl start libvirtd.service"

alias vm-off="sudo systemctl stop libvirtd.service"

alias start-cine="sudo systemctl start minidlna.service;sudo minidlnad -R;sudo systemctl restart minidlna.service"

alias stop-cine="sudo systemctl stop minidlna.service"

alias musica="ncmpcpp"

# Spicetify alias
alias spcApply="spicetify apply"

# Zoxie
eval "$(zoxide init zsh)"


#Reloads zsh config
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# partitions used space
alias used='df --total --block-size=G | grep dev/sd --color=never'

# My ps
alias myps='watch ps o pid,ppid,stat,comm'

# Size of a directory
alias sizeof='du -sh $1'

# spiecitify
#alias spicetify='$HOME/spicetify-cli/spicetify'

alias findman="man -k . | rofi -dmenu -config ~/.config/rofi/rofidmenu.rasi | awk '{print $1}' | xargs -r man -Tpdf | zathura -"

# just python as a calculator
alias calc="python3"

# calendar
alias cal="cal -m -y"

# num of installed packages
alias packages='expac -s "%-45n %m" -H M | sort -rhk 2 | nvim'

# matrix effect (better than cmatrix since it supports terminal transparency)
alias matrix='unimatrix -s 96'
alias cmatrix='unimatrix -s 96'

# 80s jpop
alias jpop='mpv --shuffle $HOME/Music/JapanesePop'

# rock
alias rock='mpv --shuffle $HOME/Music/ROCK'
#
# -------------------- KEYBINDINGS --------------------
#

bindkey "^U" backward-kill-line

bindkey "^[l" forward-word
bindkey "^[h" backward-word
bindkey "^[j" down-line-or-history
bindkey "^[k" up-line-or-history

bindkey '^ ' autosuggest-accept
bindkey '^H' autosuggest-clear

#####################
#Start up in session#
#####################
eval `~/.scripts/ssh-agent-reuse.sh` &> /dev/null

################
#pygment config#
################
#ZSH_COLORIZE_STYLE="colorful"

################
#   EXPORTS    #
################
export PATH="$HOME/.scripts:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# autosuggestions color
#autosuggestions_colorscheme_dir="$HOME/.oh-my-zsh/additional/plugins/auto-suggestions/auto-suggestions.colorscheme.conf"
#[ -f $autosuggestions_colorscheme_dir ] && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=`$autosuggestions_colorscheme_dir`

if [ -d $HOME/.oh-my-zsh/additional ];
then

    # autosuggestions_colorscheme
    autosuggestions_colorscheme=$HOME/.oh-my-zsh/additional/plugins/auto-suggestions/auto-suggestions.colorscheme.conf
    [ -f $autosuggestions_colorscheme ] && source $autosuggestions_colorscheme

    # prompt
    prompt_config=$HOME/.oh-my-zsh/additional/prompt.conf
    [ -f $prompt_config ] && source $prompt_config
fi

#######
#Pywal#
#######
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh

#######
# fzf #
#######
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

###########
#Starship#
##########
eval "$(starship init zsh)"

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
