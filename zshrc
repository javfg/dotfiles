# javilol zshrc!

# variables to define in env:
# SHOW_SHOWER: whether to show showerthoughts or not when opening a new terminal

export ZSH=$HOME/.oh-my-zsh
export VISUAL=vim
export EDITOR=vim
export PAGER="/usr/bin/most -s"
export ZSH_THEME="powerlevel10k/powerlevel10k"
export PATH=$HOME/.local/bin:$PATH

# history config
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
unsetopt SHARE_HISTORY           # Don't share history
setopt NO_SHARE_HISTORY          # Same
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
unsetopt EXTENDEDGLOB            # Don't enable extended glob stuff for now (need escape magic)

# command completion
fpath=($HOME/.dotfiles/compdef $fpath)
plugins=(zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
autoload -U compinit && compinit

# start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# powerline10k config `p10k configure`
source $HOME/.dotfiles/conf/p10k.zsh

# clear and load relevant env file and fragments
unalias -m '*'
relevant_fragments=( \
  "${HOME}/.dotfiles/envs/_$(hostname)" \
  "${HOME}/.dotfiles/fragments/global" \
  "${HOME}/.dotfiles/fragments/common/_"* \
  "${HOME}/.dotfiles/fragments/hosts/_$(hostname)" \
)
for f in "${relevant_fragments[@]}"
do
  [ -f $f ] && source $f
done

# fzf config
source $HOME/.dotfiles/conf/fzf-completion.zsh
source $HOME/.dotfiles/conf/fzf.zsh

# Show showerthoughts
[ $SHOW_SHOWER ] && $HOME/.dotfiles/showerthoughts/showerthoughts.sh
