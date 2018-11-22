# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="n8"

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
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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
plugins=(git rails lol npm osx)

source $ZSH/oh-my-zsh.sh

# User configuration
export JAVA_HOME=$(/usr/libexec/java_home)
export JUNIT_HOME='/usr/local/java/junit'

export PATH="/usr/local/opt/libpq/bin:$JAVA_HOME/bin:/Users/$USERNAME/.composer/vendor/bin:/Users/$USERNAME/.local/bin:/Users/$USERNAME/Library/Haskell/bin:/Users/$USERNAME/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin:/Users/$USERNAME/Applications:/Users/$USERNAME/bin:/usr/local/CrossPack-AVR/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
#
export PATH="$PATH:$(python3 -m site --user-base)/bin"
export PATH="$HOME/.bin:$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.asdf/installs/nodejs/8.7.0/.npm/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='/usr/local/bin/vim'
export VISUAL='/usr/local/bin/vim'
# PHP 7 to path
# export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"

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
alias bundle="nocorrect bundle"
alias ssh="ssh -C "
# alias vim="/usr/local/bin/nvim"
alias vi="/usr/local/bin/vim"
alias vif='/usr/local/bin/vim $(fzf)'

# Python:
alias python="python3"
alias pip="/usr/local/bin/pip3"
unalias rg
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
eval "$(pyenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# iTerm2:
source ~/.iterm2_shell_integration.zsh

#Aliases
alias yarn="$(which yarn) --ignore-engines"
alias be="bundle exec"
alias vim-changed="git status --porcelain | awk '{ print \$2 }' | xargs -o vim"
alias git-branch-sorted="git for-each-ref --sort=committerdate refs/heads/ --format='%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)'"
alias git-rails-pull="git pull && bundle install && rails db:migrate && rails db:migrate RAILS_ENV=test"
alias gitnp="git --no-pager"
alias psql="pgcli"
alias psql-real="/usr/local/bin/psql"
alias gti="git"
alias gits="git status"

# ASDF
source /Users/nathancornell/.asdf/asdf.sh

# Go
export GOPATH="$HOME/workspace/go"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Enable immediate history execution with '!!' (oh-my sets it to echo first but we can do this with tab):
unsetopt histverify

# fzf + ripgrep:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# bind -x '"\C-p": vim $(fzf);' # bash-only command

# Fun:
fortune -sa | cowsay -p
