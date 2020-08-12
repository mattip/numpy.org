#!/bin/sh

# See https://gohugo.io/hosting-and-deployment/hosting-on-github/#put-it-into-a-script-1

remote=${1:-origin}

if [ "$(git remote -v | grep ${remote})" == "" ]
then
    echo "git target ${remote} does not exist, check 'git remote -v'"
    exit 1;
fi

if [ "$(git status -s)" != "" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    # exit 1;
fi

if [ "$(ls -d public 2>/dev/null)" != "public" ]
then
    echo "./public does not exist, did you run hugo and check the output?"
    exit 1;
fi

echo "Deleting old publication"
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public ${remote}/gh-pages

echo "Updating gh-pages branch"
pushd public
git add --all && git commit -m "Publishing to gh-pages (via script)"

echo "Pushing to github ${target}"
git push ${target} gh-pages

