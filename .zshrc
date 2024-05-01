# Aliases
[[ -f .aliases ]] && source .aliases

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# fzf
zshplug="$HOME/.config/zsh_plugins"
fzfplugdir="$zshplug/fzf-zsh-plugin"

# options
setopt share_history

# PATH
export FZF_PATH=${HOME}/.config/fzf
export PATH=${fzfplugdir}/bin:${FZF_PATH}:$PATH

[[ -f ${fzfplugdir}/fzf-zsh-plugin.plugin.zsh ]] && source ${fzfplugdir}/fzf-zsh-plugin.plugin.zsh

# the detailed meaning of the below three variable can be found in `man zshparam`.
export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

bindkey '^[[3~'	delete-char

# persist zsh history across decontainer rebuild
if [[ -d "/commandhistory" ]] ; then 
    # ensure we can touch it
    sudo chown $USER: /commandhistory
    autoload -Uz add-zsh-hook
    append_history() { fc -W }
    add-zsh-hook precmd append_history
    export HISTFILE=/commandhistory/.zsh_history
    touch $HISTFILE
fi

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
