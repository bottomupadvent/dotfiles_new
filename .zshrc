# ++++++++++++++++++++ EXPORTS +++++++++++++++++++++ #
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/home/sols/.emacs.d/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH="/home/sols/.oh-my-zsh"
export FZF_DEFAULT_COMMAND='ag --hidden -p ~/.ag_zsh_ignore --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -H -t d . /"
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# Tree command to show the enteries of the directory
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export KEYTIMEOUT=1
export BROWSER=firefox


# ++++++++++++++++++++++ VARIABLES +++++++++++++++++++++ #
# plugins=(git)
ZSH_THEME="sorin"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true
ENABLE_CORRECTION="true" # Command autocorrection
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


# +++++++++++++++++++ SOURCING and PLUGINS +++++++++++++++++++++ #
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source ~/antigen.zsh
# Enable colors and change prompt:
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile
antigen use oh-my-zsh
antigen bundle mafredri/zsh-async
antigen bundle git
antigen bundle desyncr/auto-ls
antigen apply


# +++++++++++++++ BIND KEY ++++++++++++++ #
bindkey -v
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# ++++++++++++++++ FUNCTIONS +++++++++++++++++ #
# open directory in pcmanfm from terminal
shell_to_gui_fm () { bash /home/sols/.scripts/shell_scripts/pcman_tmux.sh }
# sendkeys to right pane in tmux
ts() { args=$@ ; tmux send-keys -t right "$args" C-m }
# Cheat sheet for all packages
ch(){ curl cheat.sh/"$1" }
# Search for packages and highlight package name
se(){ pacman -Ss "$1" | grep -B 1 '^.*/.*\s[0-9]\..*' }


# ++++++++++++++++++ ALIASES +++++++++++++++++++++ #
alias sv="sudo vim"
alias vim="nvim"
alias grep="grep --color=auto"
alias ls="ls --group-directories-first --color "
alias la="ls -a --group-directories-first --color "
alias ll="ls -al--group-directories-first --color "
alias p="sudo pacman"
alias l="less"
alias tree="tree -C"
alias pg="ping google.com"
alias sz="source ~/.zshrc"
alias config='/usr/bin/git --git-dir=/home/sols/.cfg/ --work-tree=/home/sols'


# syntax highlighting should be the last plugin to take effect
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
