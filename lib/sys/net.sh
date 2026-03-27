#!/bin/bash

net_getIp() {
    IP=$(ifconfig | grep inet | grep 255.255.255.0 | awk '{print $2"\n"}')
    echo $IP
}

net_getIpMask() {
    IP=$(ifconfig | grep inet | grep 255.255.255.0 | awk '{print $2}' | awk -F'.' '{printf $1"."$2"."$3".*\n"}' )
    echo $IP
}


net_getHostName() {
    HOSTNAME=$(uname -n)
    echo $HOSTNAME
}


net_nmap() {
    NMAP=$(nmap -v -sn $1 | grep -v "host down" | grep "report for" | awk '{print $5 $6}') 
    for OUTPUT in $NMAP
    do
        vio_print "\t${OUTPUT}"
    done
}

