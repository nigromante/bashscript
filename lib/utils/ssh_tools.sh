#!/usr/bin/env bash


#  ssh_Cert  root  proxmox
ssh_Cert() {
  user="$1"
  server="$2"
  file="~/.ssh/id_rsa_${server}"
  cmd="ssh-keygen -t rsa -b 4096 -f $file <<< y"
  echo $cmd
  eval $cmd
  cmd="ssh-copy-id -i $file $user@$server"
  echo $cmd
  eval $cmd
}

#  ssh_Exec julian@localhost "clear ; ls -al ; echo ; echo"
ssh_Exec() {
  conn="$1"
  app="$2"
  cmd='ssh -v -t $conn "$app" '
  echo $cmd
  eval $cmd
}

# ssh_X julian@localhost
ssh_X() {
  conn="$1"
  cmd="ssh -v -X $conn "
  echo $cmd
  eval $cmd
}

# ssh_DProxy julian@localhost 9999
ssh_DProxy() {
  conn="$1"
  port="$2"
  cmd="ssh -v -D $port $conn"
  echo $cmd
  eval $cmd
}

# ssh_LTunnel 9999 server2:22  julian@server  
ssh_LTunnel() {
  port="$1"
  target="$2"
  conn="$3"
  cmd="ssh -v -L $port:$target $conn"
  echo $cmd
  eval $cmd
}

ssh_LTunnelConn() {
  user="$1"
  port="$2"
  cmd="ssh -v -p $port $user@localhost"
  echo $cmd
  eval $cmd
}

ssh_RTunnelInside() {
  externConn="$1"
  externPort="$2"
  cmd="ssh -v -R ${externPort}:localhost:22 ${externConn}"
  echo $cmd
  eval $cmd
}

ssh_RTunnelOutside() {
  user="$1"
  port="$2"
  cmd="ssh -v -p $port $user@localhost"
  echo $cmd
  eval $cmd
}

