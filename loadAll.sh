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

# use a level to avoid stackoverflow
level=$1
if [[ -z $level ]]; then
  level=0
fi

if [[ $level == 1 ]]; then
  return
fi

level=$(( level + 1))

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo $SCRIPTPATH

for m in $SCRIPTPATH/*.sh
do
  if [[ $m != "loadlAll.sh" ]]
  then
    echo "Loading $m"
    . $m $level
  fi
done
