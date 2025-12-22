export NATS_URL=http://nats.porter.run:4222

pctx () {
  # pctx with no args will print all contexts that are available
  # otherwise, use `pctx myctx` to create a new context, or switch to an existing one
  if [ -z "${1}" ]; then
      ls -1 -d ~/.porter/*/ | xargs basename
      return
  fi
  export PCTX=$HOME/.porter/${1}
  mkdir -p $PCTX
  export PORTER_CONFIG=$PCTX/porter.yaml
  porter config
}

awsexport () {
  if [[ -z $1 ]]; then
    echo "Missing project id"
    return
  fi
  local cmd="ccp-cli manage cloud aws --project-id $1"
  if [[ -n "$2" ]]; then
    cmd+=" --aws-account-id $2"
  fi
  cmd+=" -- configure export-credentials --format=env"
  eval $($=cmd)
}

function pllc {
  host=$(porter config | grep host | cut -d' ' -f2)
  token=$(porter config | grep token | cut -d' ' -f2)
  project="$1"
  project="${1:-$(porter config | grep project | cut -d' ' -f2)}"
  curl -s -H "Authorization: Bearer ${token}" "${host}/api/projects/${project}/clusters"
}

alias k=kubectl
alias pk="porter kubectl --"
alias ph="porter helm --"
alias lint="GOWORK=off golangci-lint run -c .github/golangci-lint.yaml"
alias getcreds="cat ~/.aws/credentials"
alias getfig="cat ~/.aws/config"
alias ns="k ns"
alias cx="k ctx"
alias psp="porter config set-project"
alias psc="porter config set-cluster"
alias psh="porter config set-host"
alias plc="porter cluster list"
alias plp="porter project list"
alias pout="porter auth logout"
alias pin="pout; porter auth login"
alias pin-here="pin --host=http://localhost:8081"
alias pin-there="pin --host=https://dashboard.porter.run"
alias backup-fig="cp -i ~/.aws/config_backup ~/.aws/config"
alias gpo="git pull origin"
alias gba='for k in `git branch|sed s/^..//`;do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k"`\\t"$k";done|sort'
alias pk9s="porter kubectl --print-kubeconfig >! /tmp/temp-kubeconfig && KUBECONFIG=/tmp/temp-kubeconfig k9s"

alias gm="goose -dir zarf/database/migrations"
alias plint="GOWORK=off golangci-lint run -c ../.github/golangci-lint.yaml --new-from-rev=origin/main"
