#|/usr/bin/env bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
}

loader_manager

echo "root_pass : [$root_pass]"
