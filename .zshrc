# Init zpack
# [[ -d "${HOME}/.zpack" ]] || git clone https://github.com/originalnexus/zpack.git "${HOME}/.zpack"
[[ -d "${HOME}/.zpack" ]] || git clone git@github.com:OriginalNexus/zpack.git "${HOME}/.zpack"
source "${HOME}/.zpack/zpack.zsh"

# ohmyzsh libraries
zpack bundle omz-lib

# ohmyzsh plugins
zpack omz plugins/git
zpack omz plugins/sudo
zpack omz plugins/docker
zpack omz plugins/docker-compose
zpack omz plugins/kubectl
zpack omz plugins/helm
zpack omz plugins/golang
zpack omz plugins/gcloud

# Other plugins
zpack snippet https://github.com/Azure/azure-cli/raw/dev/az.completion

# Programs
zpack bundle fzf  --pattern '*linux_amd64*'       --preview --catppuccin
zpack bundle bat  --pattern '*x86_64*linux-gnu*'
zpack bundle exa  --pattern '*linux-x86_64-v*'
zpack bundle plow --pattern '*linux_amd64.tar.gz'

zpack release vmware-tanzu/velero      --pattern '*linux-amd64.tar.gz' --completion 'velero completion zsh > _velero'
zpack release Azure/kubelogin          --pattern '*linux-amd64.zip'    --completion 'kubelogin completion zsh > _kubelogin'
zpack release doitintl/kube-no-trouble --pattern '*linux-amd64.tar.gz'
zpack release wagoodman/dive           --pattern '*linux_amd64.tar.gz'

zpack snippet --bin https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell

# zsh-users
zpack bundle zsh-users

# Theme
zpack bundle powerlevel10k

zpack apply

# User config
sudo ip link set mtu 1200 eth0
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
