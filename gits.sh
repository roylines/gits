#!/bin/bash
set -e
CONFIG="$HOME/.gits"

if [ ! -f $CONFIG ];
then
    echo "No gits config found ($CONFIG)."
    echo "Please enter the first pair username > "
    read username1
    echo "Please enter the first pair email > "
    read email1
    echo "Please enter the second pair username > "
    read username2
    echo "Please enter the second pair email > "
    read email2

    echo "$username1,$email1" > $CONFIG
    echo "$username2,$email2" >> $CONFIG

    echo "created config for: $username1 ($email1), $username2 ($email2)"
fi

# git $@
