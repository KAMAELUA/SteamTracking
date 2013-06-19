#!/bin/bash

LOCKFILE=update.lock

if [ -f "$LOCKFILE" ] && kill -0 `cat $LOCKFILE` 2>/dev/null; then
	echo Still running
	exit 1
fi

echo $$ > $LOCKFILE

php update.php $1

git add -A
git commit -a -m "`git status --porcelain | sed '{:q;N;s/\n/, /g;t q}' | sed 's/^ *//g'`"
git push

rm $LOCKFILE
