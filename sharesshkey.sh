#!/bin/bash

stringContain() {
    case $2 in
        *$1*)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

copyssh() {
   ssh-copy-id root@$1
}

while read p; do
    #echo "$p"
    if stringContain "192.168.1" "$p"; then
       #printf 'Match: %-12s %s\n' "'$p'"
       ip="${p%%' '*}"
       echo $ip
    copyssh "$ip"
    else
        true
    fi
done <inventory.ini

