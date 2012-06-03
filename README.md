# Dotfiles

A collection of config files that I use.

When setting up a new system, I like to clone this git repository into `~/.dotfiles` and create
symlinks to these files in `~` with:

    $ git clone https://tupton@github.com/tupton/dotfiles.git ~/.dotfiles
    $ cd ~/.dotfiles
    $ ./create_symlinks.sh ~
