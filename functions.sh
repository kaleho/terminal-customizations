function fwd() {
  pushd ~
  rsync -avz .bash_aliases customizations $1:.
  ssh -D 5534 $1
  popd

  return 0
}

function jump() {
  pushd ~
  rsync -avz .bash_aliases customizations $1:.
  ssh $1
  popd

  return 0
}

function bhl() { # bhm - bastion host list
  mkdir -p ~/bastion_hosts

  ls -lah ~/bastion_hosts

  return 0
}

function bhm() { # bhm - bastion host mount
  BASTION_HOST=$1
  REMOTE_USERNAME=$2
  
  if [[ -z "$BASTION_HOST" ]]; then
    echo "Usage: mbh [ssh-aliased bastion host, required] [bastion host username, optional, defaults to $USER]"
    return 1
  fi

  if [[ -z "$REMOTE_USERNAME" ]]; then
    REMOTE_USERNAME=$USER
  fi

  if [[ -z "$REMOTE_USERNAME" ]]; then
    echo "Error: REMOTE_USERNAME is empty"
    return 1
  fi

  echo "Mounting $BASTION_HOST:/home/$REMOTE_USERNAME -> ~/bastion_hosts/$BASTION_HOST/home/$REMOTE_USERNAME"

  mkdir -p ~/bastion_hosts/$BASTION_HOST/home/$REMOTE_USERNAME

  sshfs -o reconnect,follow_symlinks $BASTION_HOST:/home/$REMOTE_USERNAME ~/bastion_hosts/$BASTION_HOST/home/$REMOTE_USERNAME

  echo "Mounted directory:"
  ls -lah ~/bastion_hosts/$BASTION_HOST/home/$REMOTE_USERNAME

  return 0
}

function bhu() { # bhu - bastion host unmount
  BASTION_HOST=$1
  REMOTE_USERNAME=$2

  if [[ -z "$BASTION_HOST" ]]; then
    echo "Usage: ubh [ssh-aliased bastion host, required] [bastion host username, optional, defaults to $USER]"
    return 1
  fi

  if [[ -z "$REMOTE_USERNAME" ]]; then
    REMOTE_USERNAME=$USER
  fi

  if [[ -z "$REMOTE_USERNAME" ]]; then
    echo "Error: REMOTE_USERNAME is empty"
    return 1
  fi

  echo "Unmounting ~/bastion_hosts/$BASTION_HOST/home/$REMOTE_USERNAME"

  fusermount -u ~/bastion_hosts/$BASTION_HOST/home/$REMOTE_USERNAME

  rm -r ~/bastion_hosts/$BASTION_HOST

  echo "Unmounted directory, listing mounted bastion hosts:"
  ls -lah ~/bastion_hosts

  return 0
}

function rbh() { # rmb - roam begin here
  ~/syncs/github/kaleho/roaming-terminal/roam start $(echo $USER$(pwd) | sed "s|/|_|g")
}

function reh() { # rme - roam end here
  ~/syncs/github/kaleho/roaming-terminal/roam stop $(echo $USER$(pwd) | sed "s|/|_|g")
}

function ssa { # ssa - start ssh agent
  # setup the ssh-agent
  SSH_ENV=$HOME/.ssh/environment

  echo "Initializing new SSH agent in $SSH_ENV..."

  # spawn ssh-agent
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"

  chmod 600 "${SSH_ENV}"

  . "${SSH_ENV}" > /dev/null

  /usr/bin/ssh-add

  cat $SSH_ENV

  echo "SSH agent is initialized"

  return 0
}

function sse() { # sse - set ssh environment
  # setup the ssh-agent
  SSH_ENV=$HOME/.ssh/environment

  # start the ssh-agent
  if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        ssa;
    }
  else
    ssa;
  fi

  return 0
}

sse
