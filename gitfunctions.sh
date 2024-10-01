#!/bin/bash

#  Copyright 2020 yerlibilgin
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
alias gsfor='git submodule foreach'
