# gits
## What is it?
A shell script to share contribution between two git accounts when pair programming. 
The first time you call gits you are prompted to configure two git accounts to share contributions between.
When making subsequent call to gits (using the same options that you would for git) it will randomly select a comitter and and author from the configured accounts. This results in commits being distributed between the two configured accounts and splitting contributions, for instance, on github graphs.

## How do I use it?
Instead of calling 'git' to commit to a repository use 'gits' instead. It takes all the same command line arguments as git. 

To find all options use:

	gits --help

The first time you use gits it will prompt for git usernames (spaces are allowed) and emails for the pair of developers. This is stored in ~/.gits and this file can safely removed to reset pairing.

Although you only need to use gits when committing to repositories, you can use it instead of git for all operations if you prefer.

## Forcing a user for a particular commit
If you want to take the random element out of a commit you can force the author for a commit by passing a 1 or 2 as the first argument to gits, e.g.
	
	gits 1 commit -m 'forcing the commit to the first user in the .gits file'
	gits 2 commit -m 'forcing the commit to the second user in the .gits file'

## Signing key
When git config user.signingkey is set, gits will automatically try to commit with -S when the first user is the author. 

## Installation
### Manual Installation
	$ wget https://raw.github.com/roylines/gits/master/gits.sh -O /usr/local/bin/gits
	$ chmod ugo+x /usr/local/bin/gits
	$ gits
