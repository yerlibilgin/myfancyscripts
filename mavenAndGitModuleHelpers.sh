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

echo "maven and git module helper functions"

colorCode="\e[47m\e[91m\e[4m"
resetCode="\e[0m"
allFolders=("module1" "module2" "module3")

# the modules (i.e. the folders) that each of the below
# commands will loop on
function allModules(){
  # do a simple ls
  ls

  # or return data directly.
  # echo $allFolders
}

# Set a version ($1) with a default version message,
#  then deploy, tag and push all
function releaseVersion(){
  version=$1
  mvn deploy && git commit -a -m"$version" && git push && git tag "$version" && git push --tags
}


# Set a version ($1) with a default version message,
#  then deploy and push all (no tagging this time) and different message
function newDevVersion(){
  version=$1
  mvn deploy && git commit -a -m"new development version $version" && git push
}


# Run mvn install on all the modules. Stop on the first error
function installAll() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} Install $m ${resetCode}" 
      mvn --offline install || exit $?
    ) || break
  done
}

# Run mvn deploy on all the modules. Stop on the first error
function deployAll() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} Deploy $m ${resetCode}" 
      mvn deploy || exit $?
    ) || break
  done
}


# Run mvn clean on all the modules. Stop on the first error
function cleanAll() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} Clean $m ${resetCode}" 
      mvn --offline clean || exit $?
    ) || break
  done
}

# Run git status on all the modules. Stop on the first error
function statusAll() {
  for m in `allModules`; do
    (
      cd $m || exit $?
      echo "${colorCode} Status $m ${resetCode}" 
      gst
    ) || break
  done
}


# Run git log with graph on all the modules. Stop on the first error
function glgAll() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} Log $m ${resetCode}" 
      git log --graph --abbrev-commit --decorate --all --full-history --tags
    ) || break
  done
}

# Run git push -all on all the modules. Stop on the first error
function pushAll() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} Push $m ${resetCode}" 
      git push --all
    ) || break
  done
}

# Run git pull -all on all the modules. Stop on the first error
function pullAll() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} Pull $m ${resetCode}" 
      git pull --all
    ) || break
  done
}

# Run git commit on all the modules with $1 as the message. 
# Stop on the first error
function commitAll() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} Commit $m ${resetCode}" 
      git commit -m"$1"
    )
  done
}

# Run git remote -v on all the modules. Stop on the first error
function printRemotes() {
  for m in `allModules()`; do
    (
      cd $m || exit $?
      echo "${colorCode} PrintRemote $m ${resetCode}" 
      git remove -v
    ) || break
  done
}
