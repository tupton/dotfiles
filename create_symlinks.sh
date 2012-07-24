#! /bin/bash

# Make sure we are given a directory and that it's not a symlink
DIRECTORY="$1"
if [[ ! -d "${DIRECTORY}" || -L "${DIRECTORY}" ]]; then
    echo "The target provided is not a directory: $DIRECTORY" 
    exit 1
fi

# Create symlinks to config files
for FILE in `pwd`/*
do
    BASE=`basename $FILE`

    # Exclude the README and this script
    if [[ "README.md" != "$BASE" && `basename $0` != "$BASE" ]]; then
        echo "Linking $BASE to $DIRECTORY/.$BASE ..."
        ln -s `pwd`/$BASE $DIRECTORY/.$BASE
    fi
done
