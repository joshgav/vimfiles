#! /usr/bin/env bash

dotfiles_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
source ${dotfiles_dir}/scripts/vscode.sh

export XDG_CONFIG_HOME=${HOME}/.config
export PS1='\u \w \$ '
export LESS=eFRX

export EDITOR=vi
# to handle color escape codes
set -o vi
${dotfiles_dir}/scripts/init_vim.sh # --no-update

function clear () {
    if [ -n ${TMUX+x} ]; then
        tmux clear-history
    fi
    /usr/bin/clear
}

# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#     alias grep='grep --color=auto'
# fi

if [ `uname` == 'Darwin' ]; then
  alias ll='ls -AlhF'
else
  alias ll='ls -AlhF --group-directories-first'
fi

# PATH
PATH=${HOME}/.local/bin:/usr/local/sbin:${PATH}

# add this line to ~/.vimrc to activate:
# TODO: add to scripts/init_vim.sh
# `if !empty($SHARED_VIMRC) | source $SHARED_VIMRC | endif`
export SHARED_VIMRC=${dotfiles_dir}/.vimrc

# TODO: move to separate script
git config --global alias.st 'status -sb'
git config --global user.email 'joshgavant@gmail.com'
git config --global user.name 'Josh Gavant'

# nvm
export NVM_DIR="${HOME}/.nvm"
[[ -f "${NVM_DIR}/nvm.sh" ]] && source ${NVM_DIR}/nvm.sh
[[ -f "${NVM_DIR}/bash_completion" ]] && source ${NVM_DIR}/bash_completion
PATH=${HOME}/.yarn/bin:${PATH}

# go
if [[ -x "/usr/local/go/bin/go" ]]; then
    GOROOT=/usr/local/go
    GOBIN=${GOROOT}/bin
    GOPATH=${HOME}/go
    PATH=${GOBIN}:${GOPATH}/bin:${PATH}
fi

# python
PATH=${HOME}/.local/bin:${PATH}

# XDG_RUNTIME_DIR == %t in systemd unit files
export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.sock

# start SSH agent
eval $(ssh-agent -s) > /dev/null

