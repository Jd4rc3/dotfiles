# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

source ~/.dotfiles/fzf/settings

unset rc
. "$HOME/.cargo/env"

# Starship
eval "$(starship init bash)"

# Completions from brew
for file in /home/linuxbrew/.linuxbrew/etc/bash_completion.d/*; do
    source "$file"
done

# aliases
source ~/.dotfiles/zsh/alias.sh

#Start up in session#
eval `~/.scripts/ssh-agent-reuse.sh` &> /dev/null

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

shopt -s autocd
