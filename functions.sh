function fwd() {
  pushd ~
  rsync -avz .bash_aliases customizations .ssh/config $1:.
  ssh -D 5534 $1
  popd
}

function jump() {
  pushd ~
  rsync -avz .bash_aliases customizations .ssh/config $1:.
  ssh $1
  popd
}

function setsshenv() {
  # setup the ssh-agent
  SSH_ENV=$HOME/.ssh/environment

  # start the ssh-agent
  function start_agent {
    echo "Initializing new SSH agent..."

    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"

    echo succeeded

    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
  }
  if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
  else
    start_agent;
  fi
}

setsshenv
