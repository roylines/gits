#!/bin/bash
# set -e
config="$HOME/.gits"

if [ ! -f $config ];
then
    echo "No gits config found ($config)."
    echo "Please enter the first pair username > "
    read username1
    echo "Please enter the first pair email > "
    read email1
    echo "Please enter the second pair username > "
    read username2
    echo "Please enter the second pair email > "
    read email2

    echo "$username1" > $config
    echo "$email1" >> $config
    echo "$username2" >> $config
    echo "$email2" >> $config

    echo "created config for: $username1 ($email1), $username2 ($email2)"
    exit 0
fi

r=$RANDOM
n=$(( r %= 2 ))

if [ $1 = "1" ];
then
    echo ' >>>> forcing author to first user'
    shift
    n=1
fi

if [ $1 = "2" ];
then
    echo ' >>>> forcing author to second user'
    shift
    n=2
fi

old_IFS=$IFS
IFS=$'\n'

filecontent=( `cat "$config" `)
if [ $n -eq 1 ]
then
    export GIT_COMMITTER_NAME=${filecontent[0]}
    export GIT_COMMITTER_EMAIL=${filecontent[1]}
    export GIT_AUTHOR_NAME=${filecontent[2]}
    export GIT_AUTHOR_EMAIL=${filecontent[3]}
else
    export GIT_COMMITTER_NAME=${filecontent[2]}
    export GIT_COMMITTER_EMAIL=${filecontent[3]}
    export GIT_AUTHOR_NAME=${filecontent[0]}
    export GIT_AUTHOR_EMAIL=${filecontent[1]}
fi

IFS=$old_IFS 

if [ "$1" = "commit" ]
then
    SIGNED=( `git config user.signingkey` )
    if [ -z "$SIGNED" ] 
    then
        echo " >>>> Your commit will not be signed, no signing key!"
        SIGNED_COMMAND=''
    else
        if [ $n -eq 1 ]
        then
          echo " >>>> Your commit will be signed!"
          SIGNED_COMMAND='-S'
        else
          echo " >>>> Your commit will not be signed, only signing the first author!"
          SIGNED_COMMAND=''
        fi
    fi
    git "$@" $SIGNED_COMMAND
else
    git "$@"
fi

echo " >>>> commit name: $GIT_COMMITTER_NAME, email: $GIT_COMMITTER_EMAIL"
echo " >>>> author name: $GIT_AUTHOR_NAME, email: $GIT_AUTHOR_EMAIL"
