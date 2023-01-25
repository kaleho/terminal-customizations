alias aptup="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"

alias azas="az account show"
alias azl="az login --use-device-code && az account show"
alias azll="az logout && az login --use-device-code && az account show"

alias dn="dotnet"

alias extip="curl -k -4 ip.sb"

alias gid-klho="git config --global user.email \"ray@kaleho.com\"; git config --global user.name \"Raymond A. Kaleho\""

alias k="kubectl"
alias kns="kubens"
alias ktx="kubectx"

alias ll="ls -la"

alias roam="$HOME/syncs/github/kaleho/roaming-terminal/roam"

alias rs="rsync -avzh --delete"
alias rsn="rsync -avzh -n --delete"

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
