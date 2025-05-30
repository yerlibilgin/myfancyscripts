#!/bin/bash

#  Copyright 2025 yerlibilgin
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
   

#merge all the branches to the one specified
mergeall(){
  if [ `checkbranch $1` = 1 ]
  then
    for _____mergeall in test release master bugfix hotfix
    do
      if [ `checkbranch $_____mergeall` = 1 ]
      then
         git checkout $_____mergeall
         git merge $1
      else
         echo >&2 "No branch $_____mergeall. Skipping"
      fi
    done
    #check out back to the original branch
    git checkout $1 
    retval=0  
   else
     echo >&2 "No branch with name $1"
     retval=1
   fi
   
   return "$retval"   
}


#is there a branch with the given name
checkbranch(){
  git show-ref refs/heads/$1 > /dev/null
  if [ $? = 0 ]
  then
     echo 1
  else
     echo 0
  fi   
}


getLocalBranches(){
   git branch | awk '{sub(/((\*)|( |\t)+)*/, "", $0); print}'
}



setUpstream(){
  if [ $# = 0 ]
  then
     echo >&2 "Please provide origin name"
     return 1
  fi
  
  for _____glbbb in `getLocalBranches`
  do
    if [ `checkbranch $_____glbbb` = 1 ]
    then
      git branch --set-upstream-to=$1/$_____glbbb $_____glbbb
    fi
  done
  
  return 0
}


function gitHistRemove(){
  if [ $# = 0 ]
  then
    echo "Please specify the file name to be pruned"
    return 1
  fi

  git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $1" --prune-empty --tag-name-filter cat -- --all
}


function gitGC(){
  git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
  git reflog expire --expire=now --all
  git gc --prune=now
}


function purgeTag(){
  tag=$1

  if [ $# != 1 ]
  then
     echo "Please specify the tag name"
     return 1
  fi

  git tag -d $tag
  git push --delete origin $tag
}



alias glg='git log --graph --abbrev-commit --all'
alias gca='git commit -a'
alias gitamend='git commit --amend --no-edit'


#A foreach template for git submodules
alias gsfor='git submodule foreach'
# git status for all submodules
alias gsst='git submodule foreach git status'

alias gsupdate='git submodule update'
alias gsinit='git submodule init'

#Stage all submodules
alias gsadd='git submodule foreach git add .'
# Push All Submodules
alias gspush='git submodule foreach git push'
alias gspull='git submodule foreach git pull'

# Checkout to the provided head for all submodules
# If the head exists, otherwise silently SKIP to the
# next submodule
function gscheckout() {
  if [ -z "$1" ]; then
    echo "Error: Checkout reference cannot be empty"
    return 1
  fi

  local ref="$1"

  # Checkout the submodule to version, otherwise skip
  gsfor "
    echo Trying \$name for '$ref'
    if git rev-parse --verify --quiet '$ref^{commit}' >/dev/null; then
      git checkout '$ref'
    else
      echo 'Skipping \$name: reference $ref not found'
    fi
  "
}


function gscommit() {
    if [ -z "$1" ]; then
        echo "Error: Commit message cannot be empty" >&2
        return 1
    fi

    # Escape quotes in the commit message
    local escaped_msg
    escaped_msg=$(printf '%s' "$1" | sed 's/"/\\"/g')

    # Commit in each submodule (ignore errors if nothing to commit)
    git submodule foreach "git commit -m\"$escaped_msg\" || :"
}
