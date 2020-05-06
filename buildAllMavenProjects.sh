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


# load the function and run it as
# > buildAllMavenProjects
# it will scan the current directory and for all files that are a directory and contain a pom 
# (NOT recursive) it will attempt a mvn clean install.
# It will fail on first build failure

function buildAllMavenProjects(){
   for m in *
   do
     if [[ -d $m ]]
     then
        ( cd $m
          if [[ -r pom.xml ]]
          then
             echo `pwd`
             echo 'building'
             mvn clean install
             return $?
          fi
        )

        ret=$?
        if [[ $ret != 0 ]]
        then
          echo "Build $m failed"
          return $ret;
        fi
      fi
   done
}


function listAllMavenProjects(){
  theDirs=""
   for m in *
   do
     if [[ -d $m ]]
     then
        ( cd $m
          if [[ -r pom.xml ]]
          then
             echo `pwd`
             theDirs="$theDirs $m"
             return $?
          fi
        )

        ret=$?
        if [[ $ret != 0 ]]
        then
          echo "Build $m failed"
          return $ret;
        fi
      fi
   done

    echo $theDirs;
    return 0;
}