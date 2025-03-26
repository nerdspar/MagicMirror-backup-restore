#!/bin/bash

# Simple MagicMirror Backup Script
# - Backs up config.js, custom.css
# - Backs up entire modules/ folder
# - Generates module_list

base=$HOME/MagicMirror
saveDir=$HOME/MM_backup
user_name="nerdspar"
email="your@email.com"
reponame="MagicMirror-Backup"
logfile=$base/installers/backup.log
push=true

mkdir -p "$saveDir"
echo "Backing up MagicMirror files..." | tee -a "$logfile"

# Initialize git repo if not exists
cd "$saveDir"
if [ ! -d .git ]; then
  git init
  git branch -M main
  git config user.name "$user_name"
  git config user.email "$email"
  git remote add origin "https://github.com/$user_name/$reponame.git"
fi

# Copy important files
cp -p "$base/config/config.js" "$saveDir/" 2>/dev/null
cp -p "$base/css/custom.css" "$saveDir/" 2>/dev/null

# Full modules backup
echo "Backing up entire modules directory..." | tee -a "$logfile"
rm -rf "$saveDir/modules"
cp -a "$base/modules" "$saveDir/"

# Generate module_list
echo "Generating module list..." | tee -a "$logfile"
repo_list="$saveDir/module_list"
rm -f "$repo_list"
touch "$repo_list"
for dir in "$base/modules"/*; do
  if [ -d "$dir" ] && [[ "$dir" != *"/default" ]]; then
    echo "$(basename "$dir")" >> "$repo_list"
  fi
done

# Git commit and tag
cd "$saveDir"
git add .
git commit -m "Backup on $(date)"
next_tag=$(git tag | sort -rn | head -n1)
next_tag=$((next_tag + 1))
git tag -a "$next_tag" -m "Backup on $(date)"

# Push to GitHub
if $push; then
  git push -u origin main
  git push origin --tags
fi

echo "Backup complete! Saved to $saveDir"
