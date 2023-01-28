#!/bin/bash
# git-cleanup-repo
#
# Author: Rob Miller <rob@bigfish.co.uk>
# Adapted from the original by Yorick Sijsling

git checkout main &> /dev/null

# Make sure we're working with the most up-to-date version of main.
git fetch

# Prune obsolete remote tracking branches. These are branches that we
# once tracked, but have since been deleted on the remote.
git remote prune origin

# List all the branches that have been merged fully into main, and
# then delete them. We use the remote main here, just in case our
# local main is out of date.
git branch --merged origin/main | grep -v 'main$' | xargs git branch -d

# Now the same, but including remote branches.
MERGED_ON_REMOTE=`git branch -r --merged origin/main | sed 's/ *origin\///' | grep -v 'main$'`

if [ "$MERGED_ON_REMOTE" ]; then
	echo "The following remote branches are fully merged and will be removed:"
	echo $MERGED_ON_REMOTE

	read -p "Continue (y/N)? "
	if [ "$REPLY" == "y" ]; then
		git branch -r --merged origin/main | sed 's/ *origin\///' \
			| grep -v 'main$' | xargs -I% git push origin :% 2>&1 \
			| grep --colour=never 'deleted'
		echo "Done!"
	fi
fi
