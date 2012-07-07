#!/bin/bash
set -e
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

    echo "$username1 $email1" > $config
    echo "$username2 $email2" >> $config

    echo "created config for: $username1 ($email1), $username2 ($email2)"
    exit 0
fi

r=$RANDOM
n=$(( r %= 2 ))

filecontent=( `cat "$config" `)
if [ $n -eq 1 ]
then
    GIT_COMMITTER_NAME=${filecontent[0]}
    GIT_COMMITTER_EMAIL=${filecontent[1]}
    GIT_AUTHOR_NAME=${filecontent[2]}
    GIT_AUTHOR_EMAIL=${filecontent[3]}
else
    GIT_COMMITTER_NAME=${filecontent[2]}
    GIT_COMMITTER_EMAIL=${filecontent[3]}
    GIT_AUTHOR_NAME=${filecontent[0]}
    GIT_AUTHOR_EMAIL=${filecontent[1]}
fi

echo "commit: $GIT_COMMITTER_NAME, author: $GIT_AUTHOR_NAME"
git $@
