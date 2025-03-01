alias vim=nvim
alias k=kubectl

function kge() {
	kubectl -n $1 get event --field-selector involvedObject.name=$2
}

function kgl() {
    if [[ $# -ne 1 ]]; then
	    kubectl get event --sort-by='.lastTimestamp'
    else
	    kubectl -n $1 get event --sort-by='.lastTimestamp'
    fi
}

# install ripgrep and fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# these might be different on macos
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx'

# install p10k
# install zoxide
