echo "Sourcing bash profile"

if [ -f "$HOME/.profile" ]; then
   .  $HOME/.profile
fi

if [ -f "$HOME/.bashrc" ]; then
    . $HOME/.bashrc
fi

if [ -f "$HOME/work/other/bash-git-prompt/gitprompt.sh" ]; then
   .  $HOME/work/other/bash-git-prompt/gitprompt.sh
fi

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

