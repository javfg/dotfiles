# javilol zshrc!

export ZSH=$HOME/.oh-my-zsh
export VISUAL=vim
export EDITOR=vim
export PAGER="/usr/bin/most -s"
export ZSH_THEME="powerlevel10k/powerlevel10k"

# history config
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # write to the history file immediately, not when the shell exits.
setopt NO_SHARE_HISTORY          # don't share history
setopt HIST_EXPIRE_DUPS_FIRST    # expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # do not display a line previously found.
setopt HIST_IGNORE_SPACE         # don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # don't execute immediately upon history expansion.
unsetopt EXTENDEDGLOB            # don't enable extended glob stuff for now (need escape magic)

# command completion
fpath=($HOME/.zfunc $HOME/.dotfiles/compdef $fpath)
plugins=(zsh-completions zsh-autosuggestions zsh-syntax-highlighting git-open)
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# powerline10k config `p10k configure`
source $HOME/.dotfiles/conf/p10k.zsh

# do this again after loading oh-my-zsh and its plugins because some set it back on
setopt NO_SHARE_HISTORY          # don't share history

# path management
# append a path if it's not already in the path and it exists
append_path () {
  case ":$PATH:" in
    *:"$1":*)
    ;;
  *)
    if [ -d "$1" ]; then
      PATH="${PATH:+$PATH:}$1"
    fi
  esac
}

append_path $HOME/.dotfiles/bin/hosts/_$(hostname)
append_path $GOPATH/bin
append_path $HOME/.local/bin
append_path $HOME/.cargo/bin
append_path /opt/google-cloud-sdk/bin

# clear and load relevant env file and fragments
unalias -m '*'
relevant_fragments=( \
  "$HOME/.dotfiles/envs/_$(hostname)" \
  "$HOME/.dotfiles/fragments/global" \
  "$HOME/.dotfiles/fragments/common/_"* \
  "$HOME/.dotfiles/fragments/hosts/_$(hostname)" \
)
for f in "$relevant_fragments[@]"
do
  [ -f $f ] && source $f
done
