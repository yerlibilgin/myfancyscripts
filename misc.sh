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


alias ultra7z='7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on'
alias ultra7ze='7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on'



# Copy the current path to system clipboard
# TESTED on MacOS
function pathcopy(){
  realpath $1 | pbcopy
}

