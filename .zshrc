# Path to your oh-my-zsh installation.
export ZSH=/home/ryosuke.maki/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

# Java Path
export PATH="/home/pleiades/java/8/bin:$PATH"
# Maven Path
export PATH="/home/ryosuke.maki/apache-maven-3.5.2/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export no_proxy="vms.develop.sbisec.co.jp,10.100.35.3,m5-gitlab01.jp.sbibits.com"
export TZ=JST-9
source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

setopt correct
setopt auto_cd
setopt share_history
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# don't work backspace vim
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
stty erase "^?"

# personal alias
alias ...='cd ../..'
alias ....='cd ../../..'
alias susa='/home/ryosuke.maki/ssh/ssh.sh susa'
alias baldr='/home/ryosuke.maki/ssh/ssh.sh baldr'
alias frigg='/home/ryosuke.maki/ssh/ssh.sh frigg'
alias chimaira='/home/ryosuke.maki/ssh/ssh.sh chimaira'
alias tproxy='/home/ryosuke.maki/ssh/login_script/login_tproxy.sh'
alias marble='/home/ryosuke.maki/ssh/ssh.sh marble'
alias apc='/home/ryosuke.maki/ssh/ssh.sh apc'
alias admin='/home/ryosuke.maki/ssh/ssh.sh admin'
alias marble-build='mvn clean install -T4 -DskipTest=true'
alias apcproxy1='ssh -L 2101:localhost:2101 -l sbiidev 192.168.107.101'
alias apcproxy2='ssh -L 2102:localhost:2102 -l sbiidev 192.168.107.101'

# tmux auto run config
zstyle ':completion:*:default' menu select=1
export TMUX_TMPDIR=/var/run/tmux


is_screen_running() {
    # tscreen also uses this varariable.
    [ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
        && [ "$(whence "$cmd")" != "$cmd" ]
    do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}


if ! is_screen_or_tmux_running && shell_has_started_interactively; then
    for cmd in tmux tscreen screen; do
        if whence $cmd >/dev/null 2>/dev/null; then
            $(resolve_alias "$cmd")
            break
        fi
    done
fi
