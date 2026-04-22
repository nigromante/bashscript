#!/bin/bash

folder=$(uname -n)

[[ ! -e "./backups/$folder" ]]  &&  mkdir "./backups/$folder"

cp /boot/config-$(uname -r) ./backups/$folder

