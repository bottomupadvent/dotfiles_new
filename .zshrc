#/ ++++++++++++++++++++++ VARIABLES +++++++++++++++++++++ #
# plugins=(git)
# AUTO_LS_COMMANDS=(custom_function)
# AUTO_LS_NEWLINE=false
MANPATH='/usr/share/man'
ZSH_THEME="af-magic"
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
eval "$(fasd --init auto)"

# ++++++++++++++++ FUNCTIONS +++++++++++++++++ #
fdcdh() {
  local dir
  dir=$(
    cd && fd -0 --type d --hidden | fzf --read0
  ) && cd ~/$dir || return
  if zle; then
    # allow fdcd to run inside and outside zle
    zle reset-prompt
  fi
}
zle -N fdcdh
bindkey '\eh' fdcdh

fdcdv() {
  local dir
  dir=$(
    cd /media/Volume && fd -0 -I --type d --hidden | fzf --read0
  ) && cd /media/Volume/$dir || return
  if zle; then
    # allow fdcd to run inside and outside zle
    zle reset-prompt
  fi
}
zle -N fdcdv
bindkey '\ev' fdcdv

ppdf() { 
    pandoc "$1" \
    -V linkcolor:blue \
    -V geometry:a4paper \
    -V geometry:margin=2cm \
    -o "$2"
}
auto-ls-custom_function () {
    ls --group-directories-first -X --color 
}
ap() {
    apropos -s 1 $@ | less
}
# Commit .dotfiles to git in one function
ce() {
    msg="$@"
    config add -u
    config commit -m "$msg"
    config push origin master
}
# Open files from anywhere
op() {
  local files
  files=(${(f)"$(locate --regex -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})
  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}
# open directory in pcmanfm from terminal
shell_to_gui_fm () { bash /home/sols/.scripts/shell_scripts/pcman_tmux.sh }
# sendkeys to right pane in tmux
ts() { args=$@ ; tmux send-keys -t right "$args" C-m }
# Cheat sheet for all packages
ch(){ curl cheat.sh/"$1" }
# Search for packages and highlight package name
se(){ pacman -Ss "$1" | grep -B 1 '^.*/.*\s[0-9]\..*' }

# +++++++++++++++ BIND KEY ++++++++++++++ #
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# ++++++++++++++++++++ EXPORTS +++++++++++++++++++++ #
# If you come from bash you might have to change your $PATH.
export ZSH="/home/sols/.oh-my-zsh"
export PATH=$HOME/bin:/usr/local/bin:/home/sols/.emacs.d/bin:/home/sols/Downloads/Piskel-0.14.0-64bits:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info' 
export FZF_DEFAULT_COMMAND='ag --hidden -p ~/.gitignore --ignore .git -g ""'
# Tree command to show the enteries of the directory
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="fd --ignore-file ~/.gitignore -H -t d . /"
export FZF_CTRL_T_COMMAND="$FZF_ALT_C_COMMAND"
export KEYTIMEOUT=1
export BROWSER=firefox
# Coloured man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# +++++++++++++++++++ SOURCING and PLUGINS +++++++++++++++++++++ #
# Enable colors and change prompt:
source $ZSH/oh-my-zsh.sh
source ~/.bash_profile
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle mafredri/zsh-async
antigen bundle git
# antigen bundle desyncr/auto-ls
antigen apply

# ++++++++++++++++++ ALIASES +++++++++++++++++++++ #
alias gpom='git push origin master'
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias xo="xdg-open "
alias hibernate="sudo systemctl hibernate"
alias sleep="sudo systemctl suspend"
alias m="man"
alias xo="xdg-open"
alias tk="tmux kill-server"
alias am="free -h | awk -F \" \" '{print \$4}' | sed 's/shared/ /' ; echo"
alias td="tmux detach"
alias ta="tmux attach"
alias sv="sudo nvim"
alias vim="nvim"
alias grep="grep --color=auto"
alias lsf="ls -t --color | head -n 20"
alias p="sudo pacman"
alias l="less"
alias tree="tree -C"
alias pg="ping google.com"
alias sz="source ~/.zshrc"
alias config='/usr/bin/git --git-dir=/home/sols/.cfg/ --work-tree=/home/sols'
alias cs="config status"
alias ls="ls --group-directories-first -X --color"
alias ll="ls -lha --group-directories-first -X --color"
alias la="ls -a --group-directories-first -X --color"

# Dont change the order of following lines
bindkey -v  # Vim bindings in zsh (This should at the bottom to avoid overriding)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# syntax highlighting should be the last plugin to take effect
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
