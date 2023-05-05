alias aptup="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

alias azas="az account show"
alias azl="az login --use-device-code && az account show"
alias azll="az logout && az login --use-device-code && az account show"

alias d="docker"
alias de="docker exec -it"
alias dl="docker exec -it $(echo $USER)_dev zsh"

alias dn="dotnet"

alias extip="curl -k -4 ip.sb"

alias gid-klho="git config --global user.email \"ray@kaleho.com\"; git config --global user.name \"Raymond A. Kaleho\""

alias k="kubectl"
alias kd="kubectl describe"
alias kdd="kubectl describe deploy"
alias kdp="kubectl describe pod"
alias kg="kubectl get"
alias kgd="kubectl get deploy"
alias kgp="kubectl get pod"
alias kl="kubectl logs"
alias kns="kubens"
alias ktx="kubectx"

alias ll="ls -la"

alias roam="$HOME/.roaming-terminal/roam"

alias rs="rsync -avzh --delete"
alias rsn="rsync -avzh -n --delete"

alias sst="sudo service ssh start && sudo netstat -tlnp | grep 22"
alias ssp="sudo service ssh stop && sudo netstat -tlnp | grep 22"

alias tf="terraform"
alias tfa="terraform apply"
alias tfd="terraform destroy"
alias tfi="terraform init"
alias tfv="terraform validate"
alias tg="terragrunt"
alias tga="terragrunt apply"
alias tgd="terragrunt destroy"
alias tgi="terragrunt init"
alias tgv="terragrunt validate"

alias version="lsb_release -a"
alias vmmnt="/usr/bin/vmhgfs-fuse .host:/ /home/$USER/mnt -o subtype=vmhgfs-fuse,allow_other"
