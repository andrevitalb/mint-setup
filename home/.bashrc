# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\e[0;1;38;5;44m\]\W \[\e[0;1;3;38;5;39m\](\[\e[0;1;3;38;5;39m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2)\[\e[0;1;3;38;5;39m\])\n\[\e[0;1m\]> \[\e[0m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|alacritty*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias mkdir='mkdir -p'
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.cargo/env:$HOME/.bun/bin
export WORK_PATH=$HOME/Documents/work_stuff

### Perfected commands
export PERFECTED_PATH=$WORK_PATH/originate/perfected
# Navigate to project
alias perfected="cd $PERFECTED_PATH"
# Open project in VS Code
alias perfected:code="perfected && codef ."
# Run /frontend
alias pf:dev:frontend="perfected; yarn dev:frontend"
# Run /backend
alias pf:dev:backend="perfected; yarn dev:backend"

### AV commands
export AV_PATH=$WORK_PATH/av/andrevital.com
# Navigate to project
alias av="cd $AV_PATH"
# Open project in VS Code
alias av:code="av && codef ."
# Run /frontend
alias av:dev:frontend="av; yarn dev:frontend"
# Run /backend
alias av:dev:backend="av; yarn dev:backend"

### Flip commands
export FLIP_PATH=$WORK_PATH/flip
# Navigate to project
alias flip="cd $FLIP_PATH"
# Open project in VS Code
alias flip:code="flip; cd flip-frontend; codef ."
# Run /frontend
alias flip:dev:frontend="flip; cd flip-frontend; yarn dev:frontend"
# Run /backend
alias flip:dev:backend="flip; cd flip-frontend; yarn dev:backend"
# Run /python-db
alias flip:dev:flask="flip; cd flip-python-db; \
			export FLASK_APP=app.py; \
			export FLASK_DEBUG=1; \
			flask run"

### Saatchi Art commands
export SAATCHI_PATH=$WORK_PATH/saatchi_art
# Navigate to project
alias saatchi="cd $SAATCHI_PATH"
# Open easel (FE) project in VS Code
alias saatchi:code:easel="saatchi && cd easel && codef ."
# Open legacy (saatchiart) project in VS Code
alias saatchi:code:legacy="saatchi && cd saatchiart && codef ."
# Open xgateway project in VS Code
alias saatchi:code:xgateway="saatchi && cd xgateway && codef ."
# Docker login
alias saatchi:docker="aws sso login && \
   		      (aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin 345127489059.dkr.ecr.us-west-1.amazonaws.com)"
# Pull from all git repositories
saatchipull() {
  saatchi && \
	cd easel && printf "Pulling Easel:\n" && git pull && \
	cd ../gallery && printf "Pulling Gallery:\n" && git pull && \
	cd ../imgproc && printf "Pulling Imgproc:\n" && git pull && \
	cd ../palette && printf "Pulling Palette:\n" && git pull && \
	cd ../saatchiart && printf "Pulling Legacy:\n" && git pull && \
	cd ../xdocker && printf "Pulling XDocker:\n" && git pull && \
	cd ../xgateway && printf "Pulling XGateway:\n" && git pull && \
	cd ../yzed && printf "Pulling Zed:\n" && git pull
}
# XDocker start all
alias saatchi:start="sudo service mysql stop && \
		     sudo service apache2 stop && \
		     saatchipull && \
		     saatchi && cd xdocker && \
		     ./start_all --without-pull --disable-backend"
# XDocker stop app
alias saatchi:stop="saatchi && cd xdocker && ./stop_all && \
		    sudo service mysql start && \
		    sudo service apache2 start"
# XDocker MySQL terminal access
alias saatchi:mysql="saatchi && cd xdocker/mysql && docker compose exec -ti mysql.db mysql -u root"

### Custom commands for directories/actions
# Alacritty
alias aledit="nano $HOME/.config/alacritty/alacritty.yml"
# Logo-LS
alias ls="logo-ls"
# Radian
alias r="radian"
# Turn on keyboard
alias kb="sudo rogauracore brightness 3"
# Reset KB to Eva-01 settings: sudo rogauracore single_breathing 4638ff 0c822b 2

# Kill plank
alias kp="killall plank"
# Uni folder
alias uni="cd ~/Documents/uni/8"
# Run Jupyter on current folder
alias jupyter="bash ~/Documents/system/scripts/run-jupyter.sh"
# Open any folder in VS Code & exit terminal
codef() {
    code "$1" && exit
}
# Open Nautilus browser on current folder
alias files="nautilus --browser ."
# Stupid ass misspelling clear all the time
alias celar="clear"
alias clera="clear"
