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
v() {
  local dir
  dir=$(
    cd /media/Volume && fd --ignore-file ~/.gitignore -0 -I --type d --hidden | fzf --read0
  ) && [ $dir != '' ] && cd /media/Volume/$dir || echo $'\\n'
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
gce() {
    msg="$@"
    config add -u
    config commit -m "$msg"
    config push origin master
}
# Vimwiki commit in one func
gcv() {
    msg="$@"
    cd ~/vimwiki
    git pull origin master
    git add -u
    git commit -m "$msg"
    git push origin master
}
# Open files from anywhere
op() {
  local files
  files=(${(f)"$(locate --regex -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})
  if [[ -f $files ]]
  then
     xo $files
  fi
}
# open directory in dolphin from terminal
of() { bash /home/sols/.scripts/shell_scripts/pcman_tmux.sh }
# sendkeys to right pane in tmux
ts() { args=$@ ; tmux send-keys -t right "$args" C-m }
# Cheat sheet for all packages
ch(){ curl cheat.sh/"$1" }
# Search for packages and highlight package name
se(){ pacman -Ss "$1" | grep -B 1 '^.*/.*\s[0-9]\..*' }

# +++++++++++++++ BIND KEY ++++++++++++++ #
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
zle -N shell_to_gui_fm
bindkey '\ef' shell_to_gui_fm
bindkey '^e' edit-command-line
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


# ++++++++++++++++++ ALIASES +++++++++++++++++++++ #
alias sc="systemctl "
alias it="sxiv -t "
alias mu="mupdf "
alias gpom='git push origin master'
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias xo="xdg-open "
alias smd="systemctl "
alias hibernate="sudo systemctl hibernate"
alias gn="sudo systemctl suspend"
alias m="man"
alias xo="xdg-open"
alias tk="tmux kill-server"
alias am="free -h | awk -F \" \" '{print \$4}' | sed 's/shared/ /' ; echo"
alias td="tmux detach"
alias ta="tmux attach"
alias sv="sudo nvim"
alias vim="nvim"
alias grep="grep -i --color=auto"
alias lsf="ls -t --color | head -n 20"
alias p="sudo pacman --color always "
alias l="less"
alias tree="tree -C"
alias pg="ping google.com"
alias feh="feh -. "
alias sz="source ~/.zshrc"
alias config='/usr/bin/git --git-dir=/home/sols/.cfg/ --work-tree=/home/sols'
alias cs="config status"
alias ls="ls --group-directories-first -X --color"
alias ll="ls -lha --group-directories-first -X --color"
alias la="ls -a --group-directories-first -X --color"


# +++++++++++++++++++ SOURCING and PLUGINS +++++++++++++++++++++ #
# Enable colors and change prompt:
source $ZSH/oh-my-zsh.sh
source ~/.zshenv
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle mafredri/zsh-async
antigen bundle git
# antigen bundle desyncr/auto-ls
antigen apply

# Dont change the order of following lines
bindkey -v  # Vim bindings in zsh (This should at the bottom to avoid overriding)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# syntax highlighting should be the last plugin to take effect
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
