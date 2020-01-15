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


#!bin/bash

alias softp11='pkcs11-tool --module /usr/local/lib/softhsm/libsofthsm2.so'
alias slots='softhsm2-util --show-slots'
alias deleteToken='softhsm2-util --delete-token --token '

function initSlot(){
    slot=$1
    label=$2
    softhsm2-util --init-token --slot=$slot --label $2 --pin $PIN --so-pin $SO_PIN
}

function signRSA(){
    tokenLabel=$1
    label=$2
    inputfile=$3
    outputfile=$4
    softp11 --token-label $tokenLabel -s -a $label -m  \
           SHA256-RSA-PKCS -i $inputfile -o $outputfile;
}

function pfx2Pkcs8(){
    pfxFile=$1
    pkcs8File=$2
    openssl pkcs12 -in $pfxFile -nocerts -nodes -out tmp.pem
    openssl pkcs8 -topk8 -inform PEM -outform DER -in tmp.pem -out $pkcs8File -nocrypt
    rm -fr tmp.pem
}

function importCert(){
    tokenLabel=$1
    certFile=$2
    alias=$3
    softp11 -p $PIN --token-label $tokenLabel -w $certFile -y cert -a $alias
}

function importKey(){
    tokenLabel=$1
    keyFile=$2
    alias=$3
    softp11 -p $PIN --token-label $tokenLabel -w $keyFile -y privkey -a $alias
}

function deleteObject(){
    tokenLabel=$1
    objectType=$2
    alias=$3
    softp11 -p $PIN --token-label $tokenLabel -b --type $objectType -a $alias  
}

function listObjects(){
    tokenLabel=$1
    softp11 -p $PIN --token-label $tokenLabel -O
}
