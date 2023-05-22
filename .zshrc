# Setup ZI Shell
ZI_INIT="${HOME}/.zi/init.zsh"
[[ -r "${ZI_INIT}" ]] || { mkdir -p "$(dirname "${ZI_INIT}")" && curl -sL init.zshell.dev -o "${ZI_INIT}" }
source "${ZI_INIT}" && zzinit

# Add meta plugins and annexes
zi light-mode for z-shell/z-a-meta-plugins @annexes 

# Completions
ZSH_CACHE_DIR="${ZI[HOME_DIR]}"
zi light-mode for \
  OMZL::git.zsh \
  OMZL::history.zsh \
  OMZL::vcs_info.zsh \
  OMZL::completion.zsh \
  OMZL::theme-and-appearance.zsh \
  OMZL::prompt_info_functions.zsh \
  OMZL::directories.zsh \
  OMZL::key-bindings.zsh \
  OMZP::git \
  OMZP::sudo \
  OMZP::docker OMZP::docker/_docker \
  OMZP::docker-compose OMZP::docker-compose/_docker-compose \
  OMZP::kubectl \
  OMZP::helm \
  OMZP::golang OMZP::golang/_golang \
  OMZP::gcloud \
  id-as="azure" https://github.com/Azure/azure-cli/raw/dev/az.completion

# fzf
FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--prompt='∼ ' --pointer='▶' --marker='✓'"
FZF_CTRL_T_OPTS="--height 80% --preview '{ [[ -f {} ]] && bat -n --color=always {} } || { [[ -d {} ]] && exa --tree --icons {} }'"
FZF_ALT_C_OPTS="$FZF_CTRL_T_OPTS"
zi pack="bgn-binary+keys" for fzf

# Programs
zi light-mode from="gh-r" pick="/dev/null" for \
  sbin="**/bat"                                                                            @sharkdp/bat         \
  sbin="**/exa"       atclone="cp -vf completions/exa.zsh _exa"          atpull="%atclone" @ogham/exa           \
  sbin="plow"         atclone="./plow --completion-script-zsh > _plow"  atpull="%atclone" @six-ddc/plow        \
  sbin="**/velero"    atclone="**/velero completion zsh > _velero"       atpull="%atclone" @vmware-tanzu/velero \
  sbin="**/kubelogin" atclone="**/kubelogin completion zsh > _kubelogin" atpull="%atclone" @Azure/kubelogin

# powerlevel10k
zi light-mode for @romkatv

# zsh-users
zi light-mode for \
  @zsh-users \
  atload="bindkey \"$terminfo[kcuu1]\" history-substring-search-up && bindkey \"$terminfo[kcud1]\" history-substring-search-down" zsh-users/zsh-history-substring-search

# User config
sudo ip link set mtu 1200 eth0
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

