#!/usr/bin/env bash


SSH() {
  peval ssh -v $@
}


#  ssh_Cert  root@proxmox
ssh_Cert() {
  conn="$1"

  arch="~/.ssh/id_rsa-${conn}"
  ssh-keygen -t rsa -b 4096 -f ${arch}  <<<  y
  ssh-copy-id -i ${arch} ${conn}  
}


#  ssh_Exec julian@localhost "clear ; ls -al ; echo ; echo"
ssh_Exec() {
  conn="$1"
  app="$2"

  SSH -t ${conn} "${app}" 
}


# ssh_X julian@localhost
ssh_X() {
  conn="$1"

  SSH -X ${conn}
}


# ssh_DProxy julian@localhost 9999
ssh_DProxy() {
  conn="$1"
  port="$2"

  SSH -D ${port} ${conn}
}



# ssh_LTunnel 9999 server2:22  julian@server  
ssh_LTunnel() {
  port="$1"
  target="$2"
  conn="$3"

  SSH -L ${port}:${target} ${conn}
}

ssh_LTunnelConn() {
  user="$1"
  port="$2"

  SSH -p ${port} ${user}@localhost
}



ssh_RTunnelInside() {
  externConn="$1"
  externPort="$2"

  SSH -R ${externPort}:localhost:22 ${externConn}
}

ssh_RTunnelOutside() {
  user="$1"
  port="$2"

  SSH -p ${port} ${user}@localhost
}

