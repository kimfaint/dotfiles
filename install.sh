#!/bin/bash

# Make symbolic links to all dotfiles from home directory.
#
# Warning: if a dotfile already exists in home dir it will be removed.

cd "$(dirname "$0")"
dotfiledir=`pwd`

# all files beginning with a dot but not . .. or .git
dotfiles=`ls -a | grep '^\.' | grep -v '^\.*$' | grep -v '^\.git$'`

for f in $dotfiles; do

    # skip directories
    if [ -d "$f" ]; then
        continue
    fi

    # if file exists, remove it
    if [ -e ~/$f ]; then
        rm -v -R ~/$f
    fi
    # copy to homedir (by making symbolic link from homedir)
    cp -v -sR $dotfiledir/$f ~/$f
done
