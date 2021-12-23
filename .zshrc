source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
export EDITOR=vim

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kevin/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kevin/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kevin/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kevin/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#conda deactivate

export PATH=$HOME/.local/bin:$HOME/.emacs.d/bin:$HOME/.yarn/bin:$PATH

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Aliases
# e.g. "alias k kubectl"
function na() {
	echo "alias $1='$2'" >> ~/.aliases
	source ~/.aliases
}

source ~/.aliases
