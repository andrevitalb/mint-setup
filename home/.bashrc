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

bold=$(tput bold)
normal=$(tput sgr0)

alias mkdir='mkdir -p'

### Git
alias gcm="git commit -m"
alias gps="git push"
alias gpl="git pull"

export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.cargo/env:$HOME/.bun/bin:/usr/share/dotnet/sdk
export WORK_PATH=$HOME/Documents/work_stuff
alias work="cd $WORK_PATH"

function current_branch() {
	current_branch=$(git branch --show-current)
	echo -e  "\033[36m$current_branch\033[0;39m"
}

function colored_git_pull() {
	git pull 2>&1 | grep -qE "Already up to date\.?"
	if [[ $? -eq 0 ]]; then
			echo -e "\033[32mAlready up to date\033[0;39m"
	else
			git pull
	fi
}

function current_git_pull() {
	cd $1 && echo -e "\nPulling $2 ($(current_branch)):" && colored_git_pull
}

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

### OpenWeb commands
export OPENWEB_PATH=$WORK_PATH/originate/openweb
# Navigate to project
alias openweb="cd $OPENWEB_PATH"
# Open admin-panel project in VS Code
alias ow:admin:code="openweb; codef admin-panel"
# Open conversation-api project in VS Code
alias ow:conversation:code="openweb; codef social-platform/apps/conversation-api"
# Open launcher project in VS Code
alias ow:launcher:code="openweb; codef social-platform/apps/launcher"
# Open social-db-api in VS Code
alias ow:social:code="openweb; codef social-db-api"
# Run admin client
alias ow:dev:admin="openweb; cd admin-panel; pnpm dev"
# Run launcher
alias ow:dev:launcher="openweb; cd social-platform/apps/launcher; pnpm dev"
# Run Conversation API
alias ow:dev:conversation="openweb; cd social-platform/apps/conversation-api; pnpm dev"
# Run Social DB API
alias ow:dev:social="openweb; cd social-db-api; SERVICE=social-db-api ENV=development PORT=8080 HOST=localhost DB_NAME=social-db-api DB_HOST=localhost DB_PASSWORD=password DB_PORT=5432 DB_USER=postgres GO_ENV=development GIN_MODE=debug GOMAXPROCS=8 IS_LOCAL_RUN=1 LOG_LEVEL=INFO PUBLISHERS_SERVICE_URL="" DB_LOG_LEVEL=info DB_PARAMETERIZED_QUERIES=false go run main.go server.go runserver"
# Run Social DB API migrations
alias ow:migrate:social="openweb; cd social-db-api; SERVICE=social-db-api ENV=development PORT=8080 HOST=localhost DB_NAME=social-db-api DB_HOST=localhost DB_PASSWORD=password DB_PORT=5432 DB_USER=postgres GO_ENV=development GIN_MODE=debug GOMAXPROCS=8 IS_LOCAL_RUN=1 LOG_LEVEL=INFO PUBLISHERS_SERVICE_URL="" DB_LOG_LEVEL=info DB_PARAMETERIZED_QUERIES=false go run main.go server.go migrate"
# Pull from all git repositories
openwebpull() {
	echo -e "\033[36m${bold}OpenWeb pull:${normal}" && \
	current_git_pull "$OPENWEB_PATH/admin-panel" "Admin Panel" && \
	current_git_pull "$OPENWEB_PATH/social-platform" "Monorepo" && \
	current_git_pull "$OPENWEB_PATH/social-db-api" "Social DB API" && \
	current_git_pull "$OPENWEB_PATH/comments-consumer" "Comments Consumer" && \
	current_git_pull "$OPENWEB_PATH/comments-moderation-consumer" "Comments Moderation Consumer" && \
	current_git_pull "$OPENWEB_PATH/publisher-db-api" "Publisher DB API" && \
	current_git_pull "$OPENWEB_PATH/user-db-api" "User DB API" && \
	printf "\nAll done!\n"
}
alias ow:pull="openwebpull"
# Run Kafka UI
alias ow:kafka="docker run -p 8888:8080 -e KAFKA_CLUSTERS_0_NAME=dev-kafka -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=kafka-dev-0.tncxch.c6.kafka.us-east-1.amazonaws.com:9092 -d provectuslabs/kafka-ui:latest"

## OpenWeb1 commands
export OPENWEB1_PATH=$OPENWEB_PATH/demand-platform
# Navigate to project
alias ow1="cd $OPENWEB1_PATH"
# Navigate to demand-portal
alias ow1:portal="ow1; cd apps/demand-portal;"
# Open OW1 in VS Code
alias ow1:code="ow1; codef ."
# Open OW1 demand-portal in VS Code"
alias ow1:portal:code="ow1; codef apps/demand-portal"
# Run OW1
alias ow1:dev="ow1; pnpm dev"
# Run OW1 demand-portal
alias ow1:portal:dev="ow1; cd apps/demand-portal; pnpm dev"
# Pull from all git repositories
openweb1pull() {
	echo -e "\033[36m${bold}OpenWeb1 pull:${normal}" && \
	current_git_pull "$OPENWEB1_PATH" "OpenWeb1" && \
	printf "\nAll done!\n"
}
alias ow1:pull="openweb1pull"

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
alias saatchi:code:easel="saatchi; cd easel; codef ."
# Open legacy (saatchiart) project in VS Code
alias saatchi:code:legacy="saatchi; cd saatchiart; codef ."
# Open xgateway project in VS Code
alias saatchi:code:xgateway="saatchi; cd xgateway; codef ."
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
alias saatchi:mysql="saatchi; cd xdocker/mysql; docker compose exec -ti mysql.db mysql -u root"

### Tatem
export TATEM_PATH=$WORK_PATH/av/tatem
# Navigate to project
alias tatem="cd $TATEM_PATH"
# Open project in VS Code
alias tatem:code="tatem; codef .;"
# Run /frontend
alias tatem:dev:frontend="tatem; yarn dev:frontend;"
# Run /backend
alias tatem:dev:backend="tatem; yarn dev:backend;"
# Start db
alias tatem:db="sudo service mongod stop; docker container start f8370f7fbed9;"

### Custom commands for directories/actions
# Alacritty
alias aledit="nano $HOME/.config/alacritty/alacritty.toml"
# Logo-LS
alias ls="logo-ls"
# Radian
alias r="radian"
# Android Studio
alias android="sudo /opt/android-studio/bin/studio.sh"
# Orange Data Mining
alias orange="python -m Orange.canvas"
# Turn on keyboard
alias kb="sudo rogauracore single_breathing 6a00ff 00cc07 2; sudo rogauracore brightness 3"
# Reset KB to Eva-01 settings: sudo rogauracore single_breathing 6a00ff 00cc07 2

# Kill plank
alias kp="killall plank"
# Uni folder
alias uni="cd ~/Documents/uni/10"
# Code Web Services project
alias uni:code="uni; codef web/dates-app"
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

# Switch python version (Multiple python versions)
# https://www.rosehosting.com/blog/how-to-install-and-switch-python-versions-on-ubuntu-20-04/
alias cpython="sudo update-alternatives --config python"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PNPM NVM (sort of)
pnpm-v() {
    corepack prepare pnpm@"$1" --activate
}

. "$HOME/.cargo/env"

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
