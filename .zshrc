ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/zsh_custom
ZSH_THEME="dpoggi"

plugins=(kubectl)

# oh my zsh
source $ZSH/oh-my-zsh.sh

eval "$(direnv hook zsh)"
alias k=kubectl
source <(kubectl completion zsh)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export EDITOR="emacs -nw"
alias ed=$EDITOR

# Load rbenv automatically by appending
# the following to ~/.zshrc:

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kevin/.anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kevin/.anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kevin/.anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kevin/.anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate

export PATH=$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH
