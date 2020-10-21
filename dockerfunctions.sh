#!/bin/bash

#!/bin/bash

## Copyright 2020 yerlibilgin
## 
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
## 
##     http://www.apache.org/licenses/LICENSE-2.0
## 
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

alias drmexited='docker ps -f status=exited -q | xargs docker rm'
alias lsuntagged='docker images | grep none | awk "{print \$3}"'
alias drmuntagged='docker images | grep none | awk "{print \$3}" | xargs docker rmi'
alias dps='docker ps -a --format "{{.ID}}::{{.Names}}"'
alias dpsa='docker ps -a'
alias dkillall='docker ps -aq | xargs docker kill'
alias dstopall='docker ps -aq | xargs docker stop'
alias drmcreated='docker ps -f status=created -q | xargs docker rm'
##careful!!! dc arbitrary precision calculator is overridden here
alias dc='docker-compose'
alias dcdown='dc down'
alias dcup='dc up'
alias dclogs='dc logs -f'
alias getcontainerip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"



function deleteAllVolumes(){
  for m in `docker volume ls -q`
  do
    docker volume rm $m
  done
}

function dockerattach(){
  if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "   dockerattach image_name"
    exit -1
  fi

  docker exec -it $1 /bin/sh
}

alias dimages='docker images'


function drun(){
# usage
# drun image
#    run the image in the background with -d and --rm options
#
# drun image command
#    run the image with -i --rm options and withe the specified command
#
  if [ "$#" = 1 ]
  then
     #only run an image
     echo "docker run -d --rm $1"
     docker run -d --rm $1
  else
    if [ "$#" = 2 ]
    then
       echo "docker run -i --rm $1 $2"
       docker run -i --rm $1 $2
    fi      
  fi
}

