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
  if [[ -n "$2" ]]; then
    local aws_account="--aws-account-id $2"
  fi
eval $(ccp-cli manage cloud aws --project-id $1 ${(z)aws_account} -- configure export-credentials --format=env)
}

function pllc {
  host=$(porter config | grep host | cut -d' ' -f2)
  token=$(porter config | grep token | cut -d' ' -f2)
  project="$1"
  project="${1:-$(porter config | grep project | cut -d' ' -f2)}"
  curl -s -H "Authorization: Bearer ${token}" "${host}/api/projects/${project}/clusters"
}

function plookup {
  api_url="https://api.usepylon.com/accounts/search"
  if [[ -z $1 ]]; then
    echo "Missing account name"
    return
  fi

  if [[ "$1" =~ ^[0-9]+$ ]]; then
    local ticketnum=1
  fi

  lookup_json="$(echo '{
    "filter": {
      "field": "name",
      "operator": "string_contains",
      "value": "customer"
    }
  }' | jq -r --arg name_value "$1" '.filter.value = $name_value')"

  curl -s -H "Authorization: Bearer $(op item get api.usepylon.com --fields credential --reveal)" $api_url -d "$lookup_json" | jq -r '.data[] | "\(.name): \(.custom_fields.account_project_id.value)"'
}

function pk9s {
  local KUBECONFIG=$(mktemp)
  trap "rm -f $KUBECONFIG" EXIT
  if [[ -n $1 ]]; then
    local project="--project $1"
  fi
  if [[ -n $2 ]]; then
    local cluster="--cluster $2"
  fi
  porter ${(z)project} ${(z)cluster} kubectl --print-kubeconfig >! $KUBECONFIG && KUBECONFIG=$KUBECONFIG k9s
}

function pset {
  porter config set-project $1
  porter config set-cluster $2
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
#alias pk9s="porter kubectl --print-kubeconfig >! /tmp/temp-kubeconfig && KUBECONFIG=/tmp/temp-kubeconfig k9s"
alias pkc="porter kubectl --print-kubeconfig >! /tmp/temp-kubeconfig && KUBECONFIG=/tmp/temp-kubeconfig"

alias gm="goose -dir zarf/database/migrations"
alias plint="GOWORK=off golangci-lint run -c ../.github/golangci-lint.yaml --new-from-rev=origin/main"
