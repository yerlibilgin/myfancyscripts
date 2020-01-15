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
   

function replicate(){
  olddir=$1
  newdidr=$2
  hash=$3
  message=$4
  
  (cd $olddir
  pwd 
  ls
  git checkout $hash
  cp -r * ../$newdir
  mv .git tmpgit
  cp -r .* ../$newdir
  mv tmpgit .git
  cd ../$newdir
  git add .
  git commit -m "${message}"
  )
}



function copyGitCommits(){

  declare -a commits=("hash1  message 1"
  "hash2  message 2"
  "hash3  message 3"
  "hash4  message 4"
  "hash5  message 5")
  
  ##assume old and new dir are siblings
  olddir="dir1"
  newdir="dir2"

  rm -fr $newdir && mkdir -p $newdir
  (cd $newdir && git init)

  for commit in "${commits[@]}"
  do
    hash=${commit%% *}
    message=${commit#* }
    echo HASH: $hash
    echo MESSAGE: $message
  
    replicate $olddir $newdir $hash "${message}"
    
  done
}
