#!/bin/bash

# Make symbolic links to all dotfiles from home directory.
#
# Warning: if a dotfile already exists in home dir it will be removed.

cd "$(dirname "$0")"
dotfiledir=`pwd`

# all files beginning with a dot but not . .. or .git
dotfiles=`ls -a | grep '^\.' | grep -v '^\.*$' | grep -v '^\.git$'`

dotdirs=".config/dunst .config/i3"

echo "installing dotfiles..."
for f in $dotfiles; do

    # skip directories
    if [ -d "$f" ]; then
        echo "skip $f dir"
        continue
    fi

    # if file exists, remove it
    if [ -e ~/$f ]; then
        echo "remove $f"
        rm -v -R ~/$f
    fi
    # copy to homedir (by making symbolic link from homedir)
    echo "copy by symlink $f"
    cp -v -sR $dotfiledir/$f ~/$f
done

echo "installing dotdirs"
for d in $dotdirs; do
    echo "linking $d"
    ln -v -sf $dotfiledir/$d ~/$d
done

echo "apt installing stuff I will probably use"
sudo apt install -y tmux mercurial curl snapd git vim picocom python3-pip fonts-powerline net-tools xclip kitty tig

echo "apt installing perlbrew and dependencies"
sudo apt install -y gcc patch bzip2 bzip2-libs perlbrew

echo "apt installing i3 and dependencies"
pushd .config/i3
./install.sh
popd
