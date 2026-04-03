

root_pass=julian
export root_pass=julian
sudo --preserve-env=root_pass  script.sh  -r root_pass


script.sh
#!/usr/bin/env bash

var=$1
echo $( eval "echo \${$var}")

