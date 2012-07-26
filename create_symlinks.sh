#! /bin/bash

# Make sure we are given a directory and that it's not a symlink
DESTINATION="$1"
SOURCE="`dirname $0`"

if [[ -z "$DESTINATION" ]]; then
    echo "No directory given; using $HOME"
    DESTINATION="$HOME"
fi

if [[ ! -d "$DESTINATION" || -L "$DESTINATION" ]]; then
    echo "The target provided is not a directory: $DESTINATION" 
    exit 1
fi

# Create symlinks to config files
for FILE in $SOURCE/*
do
    BASE=`basename $FILE`

    # Exclude the README and this script
    if [[ "README.md" != "$BASE" && `basename $0` != "$BASE" ]]; then
        echo "Linking $BASE to $DESTINATION/.$BASE ..."
        ln -s $SOURCE/$BASE $DESTINATION/.$BASE
    fi
done
