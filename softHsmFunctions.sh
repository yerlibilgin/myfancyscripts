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


function pfxtop8(){
   openssl pkcs12 -in $1 -nocerts -nodes -out tmp.pem
   openssl pkcs8 -topk8 -inform PEM -outform DER -in tmp.pem -out $2 -nocrypt
   rm -fr tmp.pem
}


function importCert(){
  softp11 -l --slot $1 -w $2 -y cert -a $3
}


function importKey(){
  softp11 -l --slot $1 -w $2 -y privkey -a $3
}


function deleteObject(){
  #$1: slot, $2: type, $3: label
  softp11 -l --slot $1 -b --type $2 -a $3  
}

function listObjects(){
  softp11 -l --slot $1 -O
}
