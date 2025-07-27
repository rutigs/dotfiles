export EDITOR=nvim

alias vim=nvim
alias k=kubectl
alias code=codium
alias proj=$(cd /Users/rutigs/projects)

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

finder() {
    open .
}

# install ripgrep and fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# these might be different on macos
source <(fzf --zsh)

POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx'

