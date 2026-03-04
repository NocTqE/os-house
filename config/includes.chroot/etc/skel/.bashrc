# ~/.bashrc - SylonOS

# Si pas interactif, ne rien faire
case $- in
    *i*) ;;
      *) return;;
esac

# Historique
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# Prompt SylonOS (orange)
PS1='\[\033[01;33m\]\u@sylon\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
