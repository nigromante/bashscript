#!/usr/bin/env bash

# ###############################
#  export password=secret
#  sudo --preserve-env=password ./script.sh  password
#  [secret]
# ###############################

if [[ $UID -ne 0 ]]
then
	echo "This script must be run as root." >&2
	exit 1
fi

env_pass_var=$1
password=$( eval "echo \${$env_pass_var}" )
echo "$env_pass_var=[$password]"
