export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	zsh-autosuggestions
	git
	history
	sudo
	web-search
	fast-syntax-highlighting
	copydir
	copyfile
	copydir
	copybuffer
	dirhistory
	);

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
###################
#     Aliases     #
###################
alias zshrc="nvim ~/.zshrc"
alias i3rc="nvim ~/.dotfiles/i3/config"
alias rangerc="nvim $HOME/.config/ranger"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias current-milis="data +%s%3N"
alias v="lvim"
alias vim="nvim"
alias dot="cd ~/.dotfiles"
alias kat="bat"
alias kittyrc="nvim ~/.dotfiles/kitty/kitty.conf"
alias dev="cd ~/Development"
alias ws="cd ~/Development/workspace"
alias icat="kitty +kitten icat"                                               
alias d="kitty +kitten diff"
alias z="zathura"
alias p="python3"
alias r="ranger"
alias j="java -jar"
alias y="yay"
alias l="exa --icons -la"
alias li="exa --icons"
alias todo="glow ~/Development/workspace/TODO.md"
alias ntodo="nvim ~/Development/workspace/TODO.md"


#Reloads zsh config
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# partitions used space
alias used='df --total --block-size=G | grep dev/sd --color=never'

# My ps
alias myps='watch ps o pid,ppid,stat,comm'

# Size of a directory
alias sizeof='du -sh $1'

# spiecitify
alias spicetify='$HOME/spicetify-cli/spicetify'

alias findman="man -k . | rofi -dmenu -config ~/.config/rofi/rofidmenu.rasi | awk '{print $1}' | xargs -r man -Tpdf | zathura -"

# just python as a calculator
alias calc="python3"

# calendar
alias cal="cal -m -y"

# num of installed packages
alias packages='expac -s "%-45n %m" -H M | sort -rhk 2 | nvim'

# opens a random pornhub video
alias porn='mpv "http://www.pornhub.com/random"'

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
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
